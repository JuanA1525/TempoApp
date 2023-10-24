import 'package:flutter/widgets.dart';

class Task{
  //atributos
  final String nombre;
  final String descripcion;
  final DateTime? fechaCreacion;
  final DateTime? fechaLimite;
  final int importancia;
  final State estado; //enum con los estados
  final bool? pomodoro;
  final DateTime? tiempo;

  Task({
    required this.nombre,
    required this.descripcion,
    this.fechaCreacion,
    this.fechaLimite,
    required this.importancia,
    required this.estado,
    this.pomodoro,
    this.tiempo,
  });
}