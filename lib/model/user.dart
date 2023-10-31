import 'package:tempo_app/enum/genre.dart';
import 'package:tempo_app/model/sleep.dart';
import 'package:tempo_app/model/task.dart';

class CustomUser {

  final String name;
  final String lastName;
  final String mail;
  String? password;
  final Genre genere; //enum con los generos
  final int age;
  final double weight;
  final List<Task> taskList;
  final List<Sleep> sleepList;

  static CustomUser? usuarioActual;

  CustomUser({
    required this.name,
    required this.lastName,
    this.taskList=const[],  //valor por defecto
    required this.mail,
    required this.password,
    required this.age,
    required this.weight,
    this.sleepList=const[],  //valor por defecto
    this.genere= Genre.other, // Valor por defecto
  });
}
