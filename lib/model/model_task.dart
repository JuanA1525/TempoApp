import 'package:tempo_app/model/model_custom_user.dart';

import '../enum/priority.dart';
import '../enum/state.dart';

class Task{
  //atributos
  String? id;
  final String name;
  final String? description;
  final DateTime? creationDate;
  final DateTime? limitDate;
  final int? duration;
  final eState state; 
  final ePriority priority;

  Task({
    this.id,
    required this.name,
    this.description,
    this.creationDate,
    this.limitDate,
    required this.priority,
    required this.state,
    this.duration ,
  }){
    id ??= CustomUser.usuarioActual!.mail + CustomUser.usuarioActual!.taskCount.toString();
  }
}