import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tempo_app/enum/genre.dart';
import 'package:tempo_app/model/sleep.dart';
import 'package:tempo_app/model/task.dart';

class User {

  //instanciamos la base de datos
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _userCollection = _firestore.collection('Users');

  final String name;
  final String lastName;
  final String mail;
  String? password;
  final Genre genere; //enum con los generos
  final int age;
  final double weight;
  final List<Task> taskList;
  final List<Sleep> sleepList;

  static User? usuarioActual;

  User({
    required this.name,
    required this.lastName,
    this.taskList=const[],  //valor por defecto
    required this.mail,
    required this.password,
    required this.age,
    required this.weight,
    this.sleepList=const[],  //valor por defecto
    this.genere= Genre.other, // Valor por defecto
  });

  void getUsers() async {
    //referencia a que colección vamos a utilizar
    CollectionReference collectionReferenceUsers = FirebaseFirestore.instance.collection("users");

    DocumentSnapshot snap = await FirebaseFirestore.instance.collection("users").doc("usuario1").get();
   
    //consulta a la coleccion
    QuerySnapshot consultaUsers = await collectionReferenceUsers.get();
    
    //aca vienen todos los documentos en forma de array
    if(consultaUsers.docs.isNotEmpty){

      for (var doc in consultaUsers.docs) {
        print(doc.data());
      }
    }
  }

  //funcion para añadir los usuarios
  Future<void> addUser() async{
    try{
      DocumentReference docRef = _userCollection.doc();
      /*
      User user = User(name: name, lastName: lastName, mail: mail, password: password, age: age, weight: weight)
      User.usuarioActual = user;
      User.setUsuario(user);

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

  static setUsuario(User user){
    
  }
}
