import 'package:flutter/material.dart';


class ColorPickerController extends ChangeNotifier {
  ColorPickerController(this.opciones, {int seleccionado = 0}) : _seleccionado = seleccionado;

  final List<Color> opciones;
  int _seleccionado;

  int get indiceSeleccionado => _seleccionado;
  Color get colorActual => opciones[_seleccionado];

  void seleccionar(int index) {
    if (index == _seleccionado) return; // no notificar si no cambió
    _seleccionado = index;
    notifyListeners();
  }
}