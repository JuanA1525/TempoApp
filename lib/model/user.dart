import 'package:tempo_app/enum/genre.dart';
import 'package:tempo_app/model/sleep.dart';
import 'package:tempo_app/model/task.dart';

class User {
  final String name;
  final String surName;
  final String mail;
  String? password;
  final Genre genere; //enum con los generos
  final int age;
  final double weight;
  final List<Task> taskList;
  final List<Sleep> sleepList;
  
  User({
    required this.name,
    required this.surName,
    this.taskList=const[],  //valor por defecto
    required this.mail,
    required this.password,
    required this.age,
    required this.weight,
    this.sleepList=const[],  //valor por defecto
    this.genere= Genre.other, // Valor por defecto
  });
}
