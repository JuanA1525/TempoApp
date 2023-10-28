import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tempo_app/pages/login.dart';

//instanciamos la base de datos
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _userCollection = _firestore.collection('Users');

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
  
}

class _RegisterState extends State<Register> {
  //variables de control
  TextEditingController name = TextEditingController();
  TextEditingController lastname = TextEditingController();

  final List<String> _options = ['Male', 'Female', 'Other'];
  String? _selectedOption;

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
  /*
  //se ejecuta justo antes del widget main sea lanzado
  // aca llamamos a la funcion que traerá la data de firestore
  @override
  void initState() {
    super.initState();
    getUsers();
  }
  //esta es la función
  void getUsers() async {
    //referencia a que colección vamos a utilizar
    CollectionReference collectionReferenceUsers = FirebaseFirestore.instance.collection("users");

    //consulta a la coleccion
    QuerySnapshot consultaUsers = await collectionReferenceUsers.get();
    
    //aca vienen todos los documentos en forma de array
    if(consultaUsers.docs.isNotEmpty){

      for (var doc in consultaUsers.docs) {
        print(doc.data());
      }
    }
  }
  */

  
  //funcion para añadir los usuarios
   Future<void> addUser() async{
    try{
      DocumentReference docRef = _userCollection.doc();

      await docRef.set(
        {
          "Name":name.text,
          "LastName":lastname.text,

        }
      );

    }catch(e){
      throw Exception("Hubo un error en addUser $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF352BFF),
        body: Stack(
          children: [
            // Fondo de imagen
            Image.asset(
              'assets/register_bg.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),

            // ListView superpuesto
            ListView(
              children: [
                const SizedBox(
                  height: 80,
                ),

                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.transparent,
                    child: const Center(
                        child: Text(
                      'Register',
                      maxLines: 3,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),

                Center(
                    child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    'Become a Tempo user',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )),

                const SizedBox(
                  height: 80,
                ),

                // ----------- TEXT REGISTER ------------

                Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: const Text(
                      'Let us know you better',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    )),

                // ----------- INPUT NAME ------------

                Container(
                  margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3))
                    ],
                  ),
                  child: TextField(
                    //controlador para validar nombre
                    controller: name,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),

                // ----------- INPUT LASTNAME ------------

                Container(
                  margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3))
                    ],
                  ),
                  child: TextField(
                    //controlador para validar apellido
                    controller: lastname,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Lastname',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),

                // ----------- INPUT GENDER ------------

                Container(
                  margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3))
                    ],
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _selectedOption,
                    items: _options.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedOption = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFFFFFFF),
                      hintText: 'Select your gender',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),

                // ----------- INPUT BIRTHDATE ------------

                Container(
                  margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3))
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Text(
                                'Fecha de nacimiento:',
                                style: TextStyle(
                                    fontSize: 16, color: Color(0xFF707070)),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "${selectedDate.toLocal()}".split(' ')[0],
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ----------- INPUT EMAIL ------------

                Container(
                  margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3))
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),

                // ----------- INPUT PASSWORD ------------

                Container(
                  margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3))
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),

                // ----------- BUTTON LOGIN ------------

                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3))
                      ],
                    ),
                    height: 50,
                    width: 100,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          //se llama al usuario
                          addUser();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));        
                        },
                        child: const Icon(
                          Icons.check,
                          color: Colors.blueAccent,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
