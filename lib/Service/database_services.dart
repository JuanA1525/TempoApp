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
  CollectionReference usersCollection = firestore.collection("Users");
  CollectionReference tasksCollection = firestore.collection("Tasks");
  CollectionReference sleepCollection = firestore.collection("Sleep");

  Future<CustomUser?> getUser({required String userMail}) async {
    //referencia a que colección vamos a utilizar

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
        for (String taskId in taskIds){
          DocumentSnapshot sleepSnapshot = await sleepCollection.doc(taskId).get();
          Sleep sleep = Sleep(
            sDate: sleepSnapshot["Date"],
            quality: 
              sleepSnapshot["Quality"] == "Bad" ? eQuality.good :
              sleepSnapshot["Quality"] == "Poor" ? eQuality.bad :
              sleepSnapshot["Quality"] == "Fair" ? eQuality.fair :
              sleepSnapshot["Quality"] == "Good" ? eQuality.good :
              sleepSnapshot["Quality"] == "Excelent" ? eQuality.excellent :
              eQuality.fair,
            duration: int.parse(sleepSnapshot["Duration"]),
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
        weight: double.parse(userData["Weight"]),
        genere: 
          userData["Genere"] == "Male" ? eGenere.male :
          userData["Genere"] == "Female" ? eGenere.female :
          eGenere.other,
        sleepList: auxSleepList,
        taskList: auxTaskList,
      );
      return auxUser;
    }
    else {
      return null;
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