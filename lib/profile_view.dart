import 'package:flutter/material.dart';
import 'profile_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileView();
  }
}

/// Vista: solo arma widgets. Toda la lógica vive en el ViewModel.
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileViewModel _viewModel = ProfileViewModel();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ListenableBuilder reconstruye este árbol cada vez que el
    // ViewModel llama a notifyListeners().
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        final colorTema = _viewModel.colorController.colorActual;
        final guardado = _viewModel.guardado;

        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Editar perfil'),
              backgroundColor: colorTema,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Avatar: círculo con el color del tema y la inicial
                  Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: colorTema,
                      child: _viewModel.inicialAvatar == null
                          ? const Icon(Icons.person, color: Colors.white, size: 36)
                          : Text(
                        _viewModel.inicialAvatar!,
                        style: const TextStyle(fontSize: 28, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  TextField(
                    controller: _viewModel.nombreController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: _viewModel.bioController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Bio',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text('Color', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(
                      _viewModel.colorController.opciones.length,
                          (index) {
                        final color = _viewModel.colorController.opciones[index];
                        final seleccionado =
                            _viewModel.colorController.indiceSeleccionado == index;
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () => _viewModel.colorController.seleccionar(index),
                            child: CircleAvatar(
                              backgroundColor: color,
                              child: seleccionado
                                  ? const Icon(Icons.check, color: Colors.white)
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  ElevatedButton.icon(
                    onPressed: _viewModel.guardarCambios,
                    style: ElevatedButton.styleFrom(backgroundColor: colorTema),
                    icon: const Icon(Icons.save, color: Colors.white),
                    label: const Text('Guardar cambios', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 24),

                  // Resumen: lee SOLO el estado guardado, no el borrador.
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Resumen del perfil guardado',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text('Nombre: ${guardado.nombre.isEmpty ? '(sin nombre)' : guardado.nombre}'),
                        Text('Bio: ${guardado.bio.isEmpty ? '(sin bio)' : guardado.bio}'),
                        Row(
                          children: [
                            const Text('Color: '),
                            CircleAvatar(radius: 8, backgroundColor: guardado.color),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}