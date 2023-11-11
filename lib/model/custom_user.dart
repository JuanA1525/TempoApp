import 'package:tempo_app/enum/genre.dart';
import 'package:tempo_app/model/sleep.dart';
import 'package:tempo_app/model/task.dart';

class CustomUser {

  int? taskCount;
  int? sleepCount;
  final String name;
  final String lastName;
  final String mail;
  String? password;
  final int age;
  final DateTime? birthDate;
  
  final eGenere genere; //enum con los generos
  
  final List<Task> taskList;
  final List<Sleep> sleepList;

  static CustomUser? usuarioActual;

  CustomUser({
    this.taskCount = 0,
    this.sleepCount = 0,
    
    required this.birthDate,
    required this.name,
    required this.lastName,
    required this.mail,
    required this.password,
    required this.age,
    
    this.sleepList=const[],  //valor por defecto
    this.taskList=const[],  //valor por defecto
    
    this.genere= eGenere.none, // Valor por defecto
  });

  String getPriority(int index){
    switch(usuarioActual!.taskList[index].priority.toString()){
      case "ePriority.ignore":
        return "Ignorar";
      case "ePriority.low":
        return "Baja";
      case "ePriority.mid":
        return "Media";
      case "ePriority.high":
        return "Alta";
      case "ePriority.top":
        return "Muy alta";
      default:
        return "Ignorar";
    }
  }

  String getState(int index){
    switch(usuarioActual!.taskList[index].state.toString()){
      case "eState.toDo":
        return "Por hacer";
      case "eState.done":
        return "Realizada";
      default:
        return "Ignorar";
    }
  }

}
