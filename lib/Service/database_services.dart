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
    try {
      DocumentSnapshot snapDoc = await usersCollection.doc(userMail).get();

      if (snapDoc.exists) {
        List<Task> auxTaskList = <Task>[];
        List<Sleep> auxSleepList = <Sleep>[];
        Map<String, dynamic>? userData =
            snapDoc.data() as Map<String, dynamic>?;

        List<String> taskIds = List<String>.from(userData?["TaskList"]);
        List<String> sleepIds = List<String>.from(userData?["SleepList"]);

        if (taskIds.isNotEmpty) {
          for (String taskId in taskIds) {
            DocumentSnapshot taskSnapshot =
                await tasksCollection.doc(taskId).get();
            Task task = Task(
              id: taskSnapshot["Id"],
              name: taskSnapshot["Name"],
              description: taskSnapshot["Description"],
              creationDate: convStringtoDate(taskSnapshot["CreationDate"]),
              limitDate: convStringtoDate(taskSnapshot["LimitDate"]),
              duration: int.parse(taskSnapshot["Duration"]),
              state:
                  taskSnapshot["State"] == "Done" ? eState.done : eState.toDo,
              priority: taskSnapshot["Priority"] == "Ignore"
                  ? ePriority.ignore
                  : taskSnapshot["Priority"] == "Low"
                      ? ePriority.low
                      : taskSnapshot["Priority"] == "High"
                          ? ePriority.high
                          : taskSnapshot["Priority"] == "Top"
                              ? ePriority.top
                              : ePriority.mid,
            );
            auxTaskList.add(task);
          }
        }

        if (sleepIds.isNotEmpty) {
          for (String sleepID in sleepIds) {
            DocumentSnapshot sleepSnapshot =
                await sleepCollection.doc(sleepID).get();
            Sleep sleep = Sleep(
              sDate: sleepSnapshot["Date"],
              quality: sleepSnapshot["Quality"] == "Bad"
                  ? eQuality.good
                  : sleepSnapshot["Quality"] == "Poor"
                      ? eQuality.bad
                      : sleepSnapshot["Quality"] == "Fair"
                          ? eQuality.fair
                          : sleepSnapshot["Quality"] == "Good"
                              ? eQuality.good
                              : sleepSnapshot["Quality"] == "Excelent"
                                  ? eQuality.excellent
                                  : eQuality.fair,
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
          genere: userData["Genere"] == "Male"
              ? eGenere.male
              : userData["Genere"] == "Female"
                  ? eGenere.female
                  : eGenere.other,
          birthDate: convStringtoDate(userData["BirthDate"]),
          sleepList: auxSleepList,
          taskList: auxTaskList,
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

  static Future<String> registerUser(
      {required String name,
      required String lastName,
      required String mail,
      required String password,
      required int age,
      required eGenere genere,
      required DateTime birthDate}) async {
    try {
      DocumentReference docRef = usersCollection.doc(mail);
      String errores = confirmarDatosRegistro(
          name: name,
          lastName: lastName,
          mail: mail,
          password: password,
          age: age,
          birthDate: birthDate);
      if (errores.isEmpty) {
        if (await userExists(userMail: mail)) {
          // CODIGO DE CONTROL CUANDO EXISTE USUARIO
          throw Exception("El usuario ya existe");
        }

        CustomUser.usuarioActual = CustomUser(
            name: name,
            lastName: lastName,
            mail: mail,
            password: password,
            age: age,
            genere: genere,
            birthDate: birthDate);

        await docRef.set({
          "Mail": mail,
          "Password": password,
          "Name": name,
          "LastName": lastName,
          "BirthDate": convDatetoString(birthDate),
          "Age": age.toString(),
          "Genere": convertirGeneroAString(genere),
          "TaskList": [],
          "SleepList": [],
        });
        return errores;
      } else {
        //cadena está con errores
        return confirmarDatosRegistro(
            name: name,
            lastName: lastName,
            mail: mail,
            password: password,
            age: age,
            birthDate: birthDate);
      }
    } catch (e) {
      throw Exception("Hubo un error en addUser $e");
    }
  }

  // DataTypes Functions
  static int calcularEdad(DateTime fechaNacimiento) {
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

  static DateTime convStringtoDate(String fecha) {
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

  static String convDatetoString(DateTime fecha) {
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

  static String convertirGeneroAString(eGenere genero) {
    try {
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

  static Future<bool> addTask(
      {required String name,
      required String description,
      DateTime? creationDate,
      DateTime? limitDate,
      required ePriority priority,
      required eState state,
      int? duration}) async {
    try {
      //Identificador de tarea
      int contador = ((CustomUser.usuarioActual?.taskList.length)! + 1);
      if (confirmarDatosTask(
          name: name,
          description: description,
          priority: priority,
          state: state,
          duration: duration)) {
        Task task = Task(
            id: contador,
            name: name,
            description: description,
            creationDate: creationDate,
            limitDate: limitDate,
            duration: duration,
            state: state,
            priority: priority);
        DocumentReference docRef = tasksCollection.doc(task.id.toString());
        CustomUser.usuarioActual?.taskList.add(task);
        //el usuario puede no asignar una fecha de inicio y una fecha fin
        if (task.creationDate == null && task.limitDate == null) {
          await docRef.set({
            "Id": task.id.toString(),
            "Name": task.name,
            "Description": task.description,
            "CreationDate": "null",
            "LimitDate": "null",
            "Duration": task.duration.toString(),
            "State": task.state.toString(),
            "Priority": task.priority.toString(),
          });
          return true;
        } else {
          await docRef.set({
            "Id": task.id.toString(),
            "Name": task.name,
            "Description": task.description,
            "CreationDate": convDatetoString(task.creationDate!),
            "LimitDate": convDatetoString(task.limitDate!),
            "Duration": task.duration.toString(),
            "State": task.state.toString(),
            "Priority": task.priority.toString(),
          });
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
        return true;
      }
      return false;
    } catch (e) {
      throw Exception("Hubo un error en deleteTask $e");
    }
  }

  // UNIMPLEMENTED FUNCTIONS
  static String confirmarDatosRegistro(
      {required String name,
      required String lastName,
      required String mail,
      required String password,
      required int age,
      required DateTime birthDate}) {
    String errores = "";
    //contiene numeros o caracteres especiales
    final RegExp vName = RegExp(r'^[a-zA-Z]+$');
    //Validación de apellido con referencia de emails (caracteres especiales-numeros-@)
    /*
    final RegExp vLastname = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
    caseSensitive: false,
    multiLine: false,);
    */
    final RegExp vLastname = RegExp(r'^[a-zA-Z]+$');
    final RegExp vMail = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    final RegExp vPassword = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).+$');
    
    //Verificación de validaciones
    if(name.isEmpty){
      errores += "Invalidate Name. Name is Empty\n";
    }
      else if(!vName.hasMatch(name)){
        errores += "Invalidate Name. Name does not contain only letters\n";
      }
      else if(name.length<4){
        errores += "Invalidate Name. Name must contain more than 4 letters\n";
      }
    
    if(lastName.isEmpty){
      errores += "Invalidate LastName. LastName is Empty\n";
    }
      else if(!vLastname.hasMatch(lastName)){
        errores += "Invalidate LastName. LastName does not contain only letters\n";
      }
      else if(lastName.length<4){
        errores += "Invalidate LastName. LastName must contain more than 4 letters\n";
      }
    
    if(mail.isEmpty){
      errores += "Invalidate Email. Email is Empty\n";
    }
      else if(!vMail.hasMatch(mail)){
        errores += "Invalidate Email. Email does not meet the specific conditions, please check your Email\n";
      }
      else if(mail.length<7 || mail.length>32){
        errores += "Invalidate Email. Email does not have a suitable size. Size should be 7-32 characters\n";
      }
    
    if(password.isEmpty){
      errores += "Invalidate Password. Password is Empty\n";
    }
      
      else if(!vPassword.hasMatch(password)){
        errores += "Invalidate Password. Password does not meet the specific conditions, please check your Password\n";
      }
      
      else if(password.length<6){
        errores += "Invalidate Password. Password must contain more than 8 letters\n";
      }
      
    //retornar vacío, no tiene errores
    return errores;
  }

  static confirmarDatosTask(
      {required String name,
      required String description,
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

  static setUsuario(CustomUser user) {}
}
