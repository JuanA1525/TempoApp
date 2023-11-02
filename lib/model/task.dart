import '../enum/priority.dart';
import '../enum/state.dart';

class Task{
  //atributos
  int? id;
  final String name;
  final String description;
  final DateTime? creationDate;
  final DateTime? limitDate;
  final int? duration;
  final eState state; 
  final ePriority priority;

  Task({
    this.id=0,
    required this.name,
    required this.description,
    this.creationDate,
    this.limitDate,
    required this.priority,
    required this.state,
    this.duration ,
  });
}