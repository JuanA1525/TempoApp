import '../enum/priority.dart';
import '../enum/state.dart';

class Task{
  //atributos
  final String name;
  final String description;
  final String? creationDate;
  final String? limitDate;
  final int? duration;
  final eState state; 
  final ePriority priority;

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