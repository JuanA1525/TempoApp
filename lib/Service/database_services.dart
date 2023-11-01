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

  static Future<CustomUser?> getUser({required String userMail}) async {

    try{
      DocumentSnapshot snapDoc = await usersCollection.doc(userMail).get();
   
      if(snapDoc.exists){
        print("El usuario existe");
        List<Task> auxTaskList = <Task>[];
        List<Sleep> auxSleepList = <Sleep>[];
        Map<String, dynamic>? userData = snapDoc.data() as Map<String, dynamic>?;
        print("Se obtuvo el usuario: ${userData.toString()}");

        List<String> taskIds = List<String>.from(userData?["TaskList"]);
        List<String> sleepIds = List<String>.from(userData?["SleepList"]);

        print("Se Obtuvo las listas\nTaskList: $taskIds\nSleepList: $sleepIds");
        if(taskIds.isNotEmpty){
          print("taskIds no vacio.");
          for (String taskId in taskIds){
            print("ingresamos a: $taskId");
            DocumentSnapshot taskSnapshot = await tasksCollection.doc(taskId).get();
            Task task = Task(
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
            print("Se crea la tarea: ${task.toString()}");
            auxTaskList.add(task);
          }
        }

        if(sleepIds.isNotEmpty){
          print("sleepIds no vacio.");
          for (String sleepID in sleepIds){
            print("ingresamos a: $sleepID");
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
            print("Se crea el sueño: ${sleep.toString()}");
            auxSleepList.add(sleep);
          }
        }

        CustomUser auxUser = CustomUser(
          name: userData!["Name"],
          lastName: userData["LastName"],
          mail: userData["Mail"],
          password: userData["Password"],
          age: int.parse(userData["Age"]),
          weight: double.parse(userData["Weight"]),
          genere: 
            userData["Genere"] == "Male" ? eGenere.male :
            userData["Genere"] == "Female" ? eGenere.female :
            eGenere.other,
          sleepList: auxSleepList,
          taskList: auxTaskList,
        );
        print("Se crea el usuario: ${auxUser.toString()}");
        print(auxUser.age);
        print(auxUser.weight);
        print(auxUser.genere);
        print(auxUser.taskList);
        print(auxUser.sleepList);
        print(auxUser.name);
        print(auxUser.lastName);
        print(auxUser.mail);
        print(auxUser.password);
        
        return auxUser;
      }
      else {
        return null;
      } 
    } catch(e){
      throw Exception("Hubo un error en getUser ${e.toString()}");
    }
  }

  confirmarDatosRegistro({required String name, required String lastName, required String mail, 
  required String password, required int age, required double weight}){
    return true;
  }

  //funcion para añadir los usuarios
  Future<void> refisterUser({required String name, required String lastName, required String mail, 
  required String password, required int age, required double weight}) async{
    try{
      DocumentReference docRef = usersCollection.doc();
       
      if(confirmarDatosRegistro(name: name, lastName: lastName, mail: mail, password: password, age: age, weight: weight)){
        
        CustomUser user = CustomUser(name: name, lastName: lastName, mail: mail, password: password, age: age, weight: weight);
        CustomUser.usuarioActual = user;

        await docRef.set(
          {
            "Name":name,
            "LastName":lastName,
            "Mail":mail,
            "Password":password,
            "Age":age,
            "Weight":weight,
          }
        );

      } else{
        throw Exception("Los datos no son correctos");
      }
      /*
      CustomUser user = CustomUser(name: name, lastName: lastName, mail: mail, password: password, age: age, weight: weight)
      CustomUser.usuarioActual = user;
      CustomUser.setUsuario(user);

      await docRef.set(
        {
          "Name":name.text,
          "LastName":lastname.text,
        }
      );
      */
    }catch(e){
      throw Exception("Hubo un error en addUser $e");
    }
  }

  static setUsuario(CustomUser user){
    
  }
}