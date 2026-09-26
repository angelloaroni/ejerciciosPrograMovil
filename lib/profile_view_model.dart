import 'package:flutter/material.dart';
import 'profile_model.dart';
import 'color_picker_controller.dart';

/// ViewModel: ChangeNotifier que conecta el Modelo con los controllers
/// y decide cuándo se "guarda" el perfil.
class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel()
      : colorController = ColorPickerController(const [
    Colors.indigo,
    Colors.teal,
    Colors.orange,
    Colors.purple,
    Colors.pink,
  ]) {
    // El ViewModel escucha a sus propios controllers y,
    // cuando ellos avisan un cambio, el ViewModel avisa también.
    nombreController.addListener(notifyListeners);
    bioController.addListener(notifyListeners);
    colorController.addListener(notifyListeners);
  }

  // --- Borrador: lo que el usuario está escribiendo ahora ---
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final ColorPickerController colorController;

  // --- Estado guardado: lo último que se confirmó con "Guardar cambios" ---
  ProfileModel _guardado = const ProfileModel(
    nombre: '',
    bio: '',
    color: Colors.indigo,
  );

  ProfileModel get guardado => _guardado;

  /// Letra que debe mostrar el avatar (o null si el nombre está vacío).
  String? get inicialAvatar {
    final texto = nombreController.text.trim();
    if (texto.isEmpty) return null;
    return texto[0].toUpperCase();
  }

  void guardarCambios() {
    _guardado = ProfileModel(
      nombre: nombreController.text,
      bio: bioController.text,
      color: colorController.colorActual,
    );
    notifyListeners();
  }

  @override
  void dispose() {
    nombreController.dispose();
    bioController.dispose();
    colorController.dispose();
    super.dispose();
  }
}