import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user.dart';

class DatabaseServices {

  //instanciamos la base de datos
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _userCollection = _firestore.collection('Users');

    void getUsers() async {
    //referencia a que colección vamos a utilizar
    CollectionReference collectionReferenceUsers = FirebaseFirestore.instance.collection("users");

    DocumentSnapshot snap = await FirebaseFirestore.instance.collection("users").doc("usuario1").get();
   
    //consulta a la coleccion
    QuerySnapshot consultaUsers = await collectionReferenceUsers.get();
    
  }

  //funcion para añadir los usuarios
  Future<void> addUser() async{
    try{
      DocumentReference docRef = _userCollection.doc();
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