import 'package:flutter/scheduler.dart';

import '../enum/priority.dart';
import '../enum/state.dart';

class Task{
  //atributos
  final String name;
  final String description;
  final String? creationDate;
  final String? limitDate;
  final int? duration;
  final ePriority priority;
  final eState state; 

  Task({
    required this.name,
    required this.description,
    this.creationDate,
    this.limitDate,
    required this.priority,
    required this.state,
    this.duration ,
  });
}