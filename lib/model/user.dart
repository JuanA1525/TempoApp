import 'package:tempo_app/enum/genre.dart';
import 'package:tempo_app/model/sleep.dart';
import 'package:tempo_app/model/task.dart';

class User {
  final String nombre;
  final String apellido;
  final String correo;
  String? contrasena;
  final Genre genero; //enum con los generos
  final int edad;
  final double peso;
  final List<Task> taskList;
  final List<Sleep> dreamList;
  
  User({
    required this.nombre,
    required this.apellido,
    this.taskList=const[],  //valor por defecto
    required this.correo,
    required this.contrasena,
    required this.edad,
    required this.peso,
    this.dreamList=const[],  //valor por defecto
    this.genero= Genre.other, // Valor por defecto
  });
}
