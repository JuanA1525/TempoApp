// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import '../enum/genre.dart';
import '../enum/priority.dart';
import '../enum/quality.dart';
import '../enum/state.dart';
import '../model/custom_user.dart';
import '../model/sleep.dart';
import '../model/task.dart';

class DatabaseServices {

  //instanciamos la base de datos
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference usersCollection = firestore.collection("Users");
  static CollectionReference tasksCollection = firestore.collection("Tasks");
  static CollectionReference sleepCollection = firestore.collection("Sleeps");

  // DataBase Functions
  static Future<CustomUser?> getUser({required String userMail}) async {
    try{
      DocumentSnapshot snapDoc = await usersCollection.doc(userMail).get();
   
      if(snapDoc.exists){
        List<Task> auxTaskList = <Task>[];
        List<Sleep> auxSleepList = <Sleep>[];
        Map<String, dynamic>? userData = snapDoc.data() as Map<String, dynamic>?;

        List<String> taskIds = List<String>.from(userData?["TaskList"]);
        List<String> sleepIds = List<String>.from(userData?["SleepList"]);

        if(taskIds.isNotEmpty){
          for (String taskId in taskIds){
            DocumentSnapshot taskSnapshot = await tasksCollection.doc(taskId).get();
            Task task = Task(
              id: taskSnapshot["Id"],
              name: taskSnapshot["Name"],
              description: taskSnapshot["Description"],
              creationDate: taskSnapshot["CreationDate"],
              limitDate: taskSnapshot["LimitDate"],
              duration: int.parse(taskSnapshot["Duration"]),
              state: 
                taskSnapshot["State"] == "Done" ? eState.done :
                eState.toDo,
              priority: 
                taskSnapshot["Priority"] == "Ignore" ? ePriority.ignore :
                taskSnapshot["Priority"] == "Low" ? ePriority.low :
                taskSnapshot["Priority"] == "High" ? ePriority.high :
                taskSnapshot["Priority"] == "Top" ? ePriority.top :
                ePriority.mid,
            );
            auxTaskList.add(task);
          }
        }

        if(sleepIds.isNotEmpty){
          for (String sleepID in sleepIds){
            DocumentSnapshot sleepSnapshot = await sleepCollection.doc(sleepID).get();
            Sleep sleep = Sleep(
              sDate: sleepSnapshot["Date"],
              quality: 
                sleepSnapshot["Quality"] == "Bad" ? eQuality.good :
                sleepSnapshot["Quality"] == "Poor" ? eQuality.bad :
                sleepSnapshot["Quality"] == "Fair" ? eQuality.fair :
                sleepSnapshot["Quality"] == "Good" ? eQuality.good :
                sleepSnapshot["Quality"] == "Excelent" ? eQuality.excellent :
                eQuality.fair,
              duration: double.parse(sleepSnapshot["Duration"]),
            );
            auxSleepList.add(sleep);
          }
        }

        CustomUser auxUser = CustomUser(
          name: userData!["Name"],
          lastName: userData["LastName"],
          mail: userData["Mail"],
          password: userData["Password"],
          age: int.parse(userData["Age"]),
          genere: 
            userData["Genere"] == "Male" ? eGenere.male :
            userData["Genere"] == "Female" ? eGenere.female :
            eGenere.other,
          birthDate: convStringtoDate(userData["BirthDate"]),
          sleepList: auxSleepList,
          taskList: auxTaskList,
        );
       
        return auxUser;
      }
      else {
        return null;
      } 
    } catch(e){
      throw Exception("Hubo un error en getUser ${e.toString()}");
    }
  } 
  static Future<bool> userExists({required String userMail}) async {
    try{
      DocumentSnapshot snapDoc = await usersCollection.doc(userMail).get();
      if(snapDoc.exists){
        return true;
      }
      else {
        return false;
      } 
    } catch(e){
      throw Exception("Hubo un error en userExists ${e.toString()}");
    }
  }
  static Future<void> registerUser({required String name, required String lastName, required String mail, 
  required String password, required int age, required eGenere genere, required DateTime birthDate}) async{
    try{

      DocumentReference docRef = usersCollection.doc(mail);
       
      if(confirmarDatosRegistro(name: name, lastName: lastName, mail: mail, password: password, age: age, birthDate: birthDate)){
        
        if(await userExists(userMail: mail)){
          // CODIGO DE CONTROL CUANDO EXISTE USUARIO
          throw Exception("El usuario ya existe");
        }

        CustomUser.usuarioActual = CustomUser(name: name, lastName: lastName, mail: mail, 
        password: password, age: age, genere: genere, birthDate: birthDate);

        await docRef.set(
          {
            "Mail":mail,
            "Password":password,
            "Name":name,
            "LastName":lastName,
            "BirthDate":convDatetoString(birthDate),
            "Age":age.toString(),
            "Genere": convertirGeneroAString(genere),
            "TaskList":[],
            "SleepList":[],
          }
        );

      } else{
        throw Exception("Los datos no son correctos");
      }
    }catch(e){
      throw Exception("Hubo un error en addUser $e");
    }
  }
  
  // DataTypes Functions
  static int calcularEdad(DateTime fechaNacimiento) {
    try {
      final now = DateTime.now();
      final edad = now.year - fechaNacimiento.year;

      if (now.month < fechaNacimiento.month ||
          (now.month == fechaNacimiento.month && now.day < fechaNacimiento.day)) {
        return edad - 1;
      }
      return edad;
    } catch (e) {
      throw Exception("Error al calcular la edad: $e");
    }
  }
  static DateTime convStringtoDate(String fecha) {
    try {
      // Divide la cadena en día, mes y año
      List<String> partes = fecha.split('/');
      
      if (partes.length != 3) {
        throw FormatException("El formato de fecha debe ser dd/mm/yyyy");
      }
      
      int dia = int.parse(partes[0]);
      int mes = int.parse(partes[1]);
      int anio = int.parse(partes[2]);
      
      // Crea y devuelve el objeto DateTime
      return DateTime(anio, mes, dia);
    } catch (e) {
      throw Exception("Error al convertir la fecha: $e");
    }
  }
  static String convDatetoString(DateTime fecha) {
    try{
      final dia = fecha.day.toString().padLeft(2, '0'); // Agrega ceros a la izquierda si es necesario
      final mes = fecha.month.toString().padLeft(2, '0');
      final anio = fecha.year;

      return "$dia/$mes/$anio";
    } catch (e) {
      throw Exception("Error al convertir la fecha: $e");
    }
  }
  static String convertirGeneroAString(eGenere genero) {
    try{
      switch (genero) {
        case eGenere.male:
          return "Male";
        case eGenere.female:
          return "Female";
        default:
          return "Other"; // Valor predeterminado en caso de un género desconocido
      }
    } catch (e) {
      throw Exception("Error al convertir el genero: $e");
    }
  }

  static Future<bool> addTask({required Task task}) async{
    try{
      //Identificador de tarea
      task.id = ((CustomUser.usuarioActual?.taskList.length)!+1);

      DocumentReference docRef = tasksCollection.doc(task.id.toString());
      CustomUser.usuarioActual?.taskList.add(task);
      await docRef.set(
        {
          "Id":task.id.toString(),
          "Name":task.name,
          "Description":task.description,
          "CreationDate":task.creationDate,
          "LimitDate":task.limitDate,
          "Duration":task.duration,
          "State":task.state.toString(),
          "Priority":task.priority.toString(),
        }
      );
      return true;
    }catch(e){
      throw Exception("Hubo un error en addTask $e");
    }
  }
 
  static bool deleteTask({required Task task}){
    try{
      if(CustomUser.usuarioActual!.taskList.isNotEmpty){
        CustomUser.usuarioActual?.taskList.remove(task);
        tasksCollection.doc(task.id.toString()).delete();
        return true;
      }
      return false;
    }catch(e){
      throw Exception("Hubo un error en deleteTask $e");
    }
  }

  // UNIMPLEMENTED FUNCTIONS
  static confirmarDatosRegistro({required String name, required String lastName, required String mail, 
  required String password, required int age, required DateTime birthDate}){
    return true;
  }
  static setUsuario(CustomUser user){
    
  }
}