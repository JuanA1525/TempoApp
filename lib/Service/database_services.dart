// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import '../enum/genre.dart';
import '../enum/priority.dart';
import '../enum/quality.dart';
import '../enum/state.dart';
import '../model/model_custom_user.dart';
import '../model/model_sleep.dart';
import '../model/model_task.dart';

class DatabaseServices {

  // DataBase References
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference usersCollection = firestore.collection("Users");
  static CollectionReference tasksCollection = firestore.collection("Tasks");
  static CollectionReference sleepCollection = firestore.collection("Sleeps");

  // DataBase Functions
  static Future<CustomUser?> getUser({required String userMail}) async {
    try {
      DocumentSnapshot snapDoc = await usersCollection.doc(userMail).get();

      if (snapDoc.exists) {
        int contTasks = 0;
        int contSleeps = 0;
        List<Task> auxTaskList = <Task>[];
        List<Sleep> auxSleepList = <Sleep>[];
        Map<String, dynamic>? userData =
            snapDoc.data() as Map<String, dynamic>?;

        List<String>? taskIds = List<String>.from(userData?["TaskList"]);
        List<String>? sleepIds = List<String>.from(userData?["SleepList"]);

        if (taskIds.isNotEmpty) {
          for (String taskId in taskIds) {
            contTasks++;
            DocumentSnapshot taskSnapshot =
                await tasksCollection.doc(taskId).get();

            Task task = Task(
              id: taskSnapshot["Id"],
              name: taskSnapshot["Name"],
              description: taskSnapshot["Description"],
              creationDate: convStringToDate(taskSnapshot["CreationDate"]),
              limitDate: convStringToDate(taskSnapshot["LimitDate"]),
              duration: int.parse(taskSnapshot["Duration"]),
              state: taskSnapshot["State"] == "eState.done"
                  ? eState.done
                  : eState.toDo,
              priority: taskSnapshot["Priority"] == "ePriority.ignore"
                  ? ePriority.ignore
                  : taskSnapshot["Priority"] == "ePriority.low"
                      ? ePriority.low
                      : taskSnapshot["Priority"] == "ePriority.high"
                          ? ePriority.high
                          : taskSnapshot["Priority"] == "ePriority.top"
                              ? ePriority.top
                              : ePriority.mid,
            );
            auxTaskList.add(task);
          }
        }

        if (sleepIds.isNotEmpty) {
          for (String sleepID in sleepIds) {
            contSleeps++;
            DocumentSnapshot sleepSnapshot =
                await sleepCollection.doc(sleepID).get();
            Sleep sleep = Sleep(
              sDate: sleepSnapshot["Date"],
              quality: sleepSnapshot["Quality"] == "Good"
                  ? eQuality.good
                  : sleepSnapshot["Quality"] == "Bad"
                      ? eQuality.bad
                      : sleepSnapshot["Quality"] == "Fair"
                          ? eQuality.fair
                          : sleepSnapshot["Quality"] == "Excellent"
                              ? eQuality.excellent
                              : eQuality.fair,
              duration: double.parse(sleepSnapshot["Duration"]),
            );
            auxSleepList.add(sleep);
          }
        }

        CustomUser auxUser = CustomUser(
          name: userData!["Name"],
          mail: userData["Mail"],
          password: userData["Password"],
          age: int.parse(userData["Age"]),
          genere: userData["Genere"] == "Male"
              ? eGenere.male
              : userData["Genere"] == "Female"
                  ? eGenere.female
                  : eGenere.none,
          birthDate: convStringToDate(userData["BirthDate"]),
          sleepList: auxSleepList,
          taskList: auxTaskList,
          lastName: userData["LastName"],
          taskCount: contTasks,
          sleepCount: contSleeps,
        );

        return auxUser;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Hubo un error en getUser ${e.toString()}");
    }
  }

  static Future<bool> userExists({required String userMail}) async {
    try {
      DocumentSnapshot snapDoc = await usersCollection.doc(userMail).get();
      if (snapDoc.exists) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Hubo un error en userExists ${e.toString()}");
    }
  }

  static Future<bool> registerUser({
    required BuildContext context,
    required String name,
    required String lastName,
    required String mail,
    required String password,
    required int age,
    required eGenere genere,
    required DateTime birthDate,
  }) async {
    try {
      DocumentReference docRef = usersCollection.doc(mail);

      if (await userExists(userMail: mail)) {
        // CODIGO DE CONTROL CUANDO EXISTE USUARIO
        return false;
      } else {
        CustomUser.usuarioActual = CustomUser(
          name: name,
          lastName: lastName,
          mail: mail,
          password: password,
          age: age,
          genere: genere,
          birthDate: birthDate,
        );

        await docRef.set({
          "Mail": mail,
          "Password": password,
          "Name": name,
          "LastName": lastName,
          "BirthDate": convDateToString(birthDate),
          "Age": age.toString(),
          "Genere": convGenderToString(genere),
          "TaskList": [],
          "SleepList": [],
          "TaskCount": 0,
          "SleepCount": 0
        });

        return true;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> addTask({
    required String name,
    String? description,
    DateTime? creationDate,
    DateTime? limitDate,
    required ePriority priority,
    required eState state,
    int? duration,
  }) async {
    try {
      // Identificador de tarea

      if (confirmTaskData(
        name: name,
        description: description,
        priority: priority,
        state: state,
        duration: duration,
      )) {
        Task task = Task(
          name: name,
          description: description,
          creationDate: creationDate,
          limitDate: limitDate,
          duration: duration,
          state: state,
          priority: priority,
        );

        DocumentReference docRef = tasksCollection.doc(task.id.toString());
        CustomUser? currentUser = CustomUser.usuarioActual;

        if (currentUser != null) {
          currentUser.taskList.add(task);

          if (task.creationDate == null && task.limitDate == null) {
            await docRef.set({
              "Id": task.id.toString(),
              "Name": task.name,
              "Description": task.description,
              "CreationDate": convDateToString(DateTime.now()),
              "LimitDate":
                  convDateToString(DateTime.now().add(const Duration(days: 5))),
              "Duration": task.duration.toString(),
              "State": task.state.toString(),
              "Priority": task.priority.toString(),
            });
          } else {
            await docRef.set({
              "Id": task.id.toString(),
              "Name": task.name,
              "Description": task.description,
              "CreationDate": convDateToString(task.creationDate!),
              "LimitDate": convDateToString(task.limitDate!),
              "Duration": task.duration.toString(),
              "State": task.state.toString(),
              "Priority": task.priority.toString(),
            });
          }
          updateUser();
          return true;
        }
      }
      return false;
    } catch (e) {
      throw Exception("Hubo un error en addTask $e");
    }
  }

  static bool deleteTask({required Task task}) {
    try {
      if (CustomUser.usuarioActual!.taskList.isNotEmpty) {
        CustomUser.usuarioActual?.taskList.remove(task);
        tasksCollection.doc(task.id.toString()).delete();
        CustomUser.usuarioActual?.taskCount =
            CustomUser.usuarioActual!.taskCount! - 1;
        updateUser();
        return true;
      }
      return false;
    } catch (e) {
      throw Exception("Hubo un error en deleteTask $e");
    }
  }

  static Future<bool> login(
      {required String mail, required String password}) async {
    try {
      CustomUser? user = await getUser(userMail: mail);

      if (user != null) {
        if (password == user.password) {
          CustomUser.usuarioActual = user;
          return true;
        } else {
          // CODIGO DE CONTROL CUANDO LA CONTRASEÑA ES INCORRECTA
          return false;
        }
      } else {
        // CODIGO DE CONTROL CUANDO NO EXISTE USUARIO
        return false;
      }
    } catch (e) {
      throw Exception("Hubo un error en login $e");
    }
  }

  static bool logout() {
    try {
      CustomUser.usuarioActual = null;
      return true;
    } catch (e) {
      throw Exception("Hubo un error en logout $e");
    }
  }

  static Future<bool> updateUser() async {
    try {
      if (CustomUser.usuarioActual != null) {
        List<String>? auxTaskIds = [];
        List<String>? auxSleepList = [];

        for (Task tk in CustomUser.usuarioActual!.taskList) {
          auxTaskIds.add(tk.id.toString());
        }

        for (Sleep sl in CustomUser.usuarioActual!.sleepList) {
          auxSleepList.add(sl.id.toString());
        }

        CustomUser.usuarioActual!.taskCount =
            CustomUser.usuarioActual!.taskList.length;
        CustomUser.usuarioActual!.sleepCount =
            CustomUser.usuarioActual!.sleepList.length;

        DocumentReference docRef =
            usersCollection.doc(CustomUser.usuarioActual!.mail);
        await docRef.update({
          "Mail": CustomUser.usuarioActual!.mail,
          "Password": CustomUser.usuarioActual!.password,
          "Name": CustomUser.usuarioActual!.name,
          "LastName": CustomUser.usuarioActual!.lastName,
          "BirthDate": convDateToString(CustomUser.usuarioActual!.birthDate!),
          "Age": CustomUser.usuarioActual!.age.toString(),
          "Genere": convGenderToString(CustomUser.usuarioActual!.genere),
          "TaskList": auxTaskIds,
          "SleepList": auxSleepList,
          "TaskCount": CustomUser.usuarioActual!.taskCount,
          "SleepCount": CustomUser.usuarioActual!.sleepCount
        });
        return true;
      } else {
        throw Exception("No hay usuario actual");
      }
    } catch (e) {
      throw Exception("Hubo un error en updateUser $e");
    }
  }

  // DataTypes Functions
  static int calculateAge(DateTime fechaNacimiento) {
    try {
      final now = DateTime.now();
      final edad = now.year - fechaNacimiento.year;

      if (now.month < fechaNacimiento.month ||
          (now.month == fechaNacimiento.month &&
              now.day < fechaNacimiento.day)) {
        return edad - 1;
      }
      return edad;
    } catch (e) {
      throw Exception("Error al calcular la edad: $e");
    }
  }

  static DateTime convStringToDate(String fecha) {
    try {
      // Divide la cadena en día, mes y año
      List<String> partes = fecha.split('/');

      if (partes.length != 3) {
        throw const FormatException("El formato de fecha debe ser dd/mm/yyyy");
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

  static String convDateToString(DateTime fecha) {
    try {
      final dia = fecha.day
          .toString()
          .padLeft(2, '0'); // Agrega ceros a la izquierda si es necesario
      final mes = fecha.month.toString().padLeft(2, '0');
      final anio = fecha.year;

      return "$dia/$mes/$anio";
    } catch (e) {
      throw Exception("Error al convertir la fecha: $e");
    }
  }

  static String convGenderToString(eGenere genero) {
    try {
      switch (genero) {
        case eGenere.male:
          return "Male";
        case eGenere.female:
          return "Female";
        default:
          return "None"; // Valor predeterminado en caso de un género desconocido
      }
    } catch (e) {
      throw Exception("Error al convertir el genero: $e");
    }
  }

  static bool confirmTaskData(
      {required String name,
      String? description,
      String? creationDate,
      String? limitDate,
      required ePriority priority,
      required eState state,
      int? duration}) {
    //Por ahora:
    if (duration! > 0) {
      return true;
    } else {
      return false;
    }
  }
}
