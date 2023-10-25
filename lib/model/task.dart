import 'package:flutter/widgets.dart';

class Task{
  //atributos
  final String name;
  final String description;
  final DateTime? creationDate;
  final DateTime? limitDate;
  final int priority;
  final State state; //enum con los estados
  final bool? pomodoro;
  final DateTime? duration;

  Task({
    required this.name,
    required this.description,
    this.creationDate,
    this.limitDate,
    required this.priority,
    required this.state,
    this.pomodoro,
    this.duration ,
  });
}