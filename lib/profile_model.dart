import 'package:flutter/material.dart';


class ProfileModel {
  final String nombre;
  final String bio;
  final Color color;

  const ProfileModel({
    required this.nombre,
    required this.bio,
    required this.color,
  });
}