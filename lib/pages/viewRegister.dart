import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tempo_app/Service/database_services.dart';
import 'package:tempo_app/enum/genre.dart';
import 'package:tempo_app/pages/viewLogin.dart';

class Register extends StatefulWidget {
  const Register({super.key,});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  //--------------Control Variables-------------------
  TextEditingController cName = TextEditingController();
  TextEditingController cLastname = TextEditingController();
  TextEditingController cMail = TextEditingController();
  TextEditingController cPassword = TextEditingController();

  eGenere cGender = eGenere.none;

  DateTime? cBirthdate;

  final _formRegisterKey= GlobalKey<FormState>();

    final RegExp vFirstname = RegExp(r'^[a-zA-Z ]+$');
    final RegExp vLastname = RegExp(r'^[a-zA-Z ]+$');
    final RegExp vMail = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    final RegExp vPassword = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).+$');

  final List<String> _options = ['Masculino', 'Femenino'];
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
        //Controlador fecha
        cBirthdate = selectedDate;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF352BFF),
        body: Stack(
          children: [
            
            Image.asset(
              'assets/register_bg.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),

            
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
                      'Registrate',
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
                    'Convertite en un usuario Tempo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    ),
                  )
                ),

                const SizedBox(
                  height: 80,
                ),

                // ----------- TEXT REGISTER ------------

                Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: const Text(
                    'Dejanos conocerte mejor',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  )
                ),

                Form(
                  key: _formRegisterKey,
                  child: Column(
                  children: [
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
                        child: TextFormField(
                          //Name Controller
                          controller: cName,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Nombre',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                          ),
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Por favor ingrese un nombre.\n";
                            }
                            else if(!vFirstname.hasMatch(value)){
                              return "El nombre solo debe contener letras.\n";
                            }
                            else if(value.length<3){
                              return "EL nombre tiene que tener al menos 3 caracteres\n";
                            }
                            return null;
                          },
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
                        child: TextFormField(
                          //LastName Controller
                          controller: cLastname,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Apellidos',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                          ),
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Por favor ingrese un apellido.\n";
                            }
                            else if(!vLastname.hasMatch(value)){
                              return "El apellido solo debe contener letras.\n";
                            }
                            else if(value.length<3){
                              return "EL apellido tiene que tener al menos 3 caracteres\n";
                            }
                            return null;
                          },
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor seleccione su género';
                            }
                            return null;
                          },
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
                              switch (_selectedOption) {
                                case "Masculino":
                                  cGender = eGenere.male;
                                  break;
                                case "Femenino":
                                  cGender = eGenere.female;
                                  break;
                                default:
                                  cGender = eGenere.none;
                                  break;
                              }
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFFFFFFF),
                            hintText: 'Seleccione su género',
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
                        child: TextFormField(
                          //Email Controller
                          controller: cMail,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Correo electrónico',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                          ),
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Por favor ingrese un correo electrónico.\n";
                            }
                            else if(!vMail.hasMatch(value)){
                              return "El correo electrónico no es válido.\n";
                            }
                            return null;
                          },
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
                        child: TextFormField(
                          //Password Controller
                          controller: cPassword,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Contraseña',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                          ),
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Por favor ingrese una contraseña.\n";
                            }
                            else if(!vPassword.hasMatch(value)){
                              return "La contraseña debe tener al menos 8 caracteres, una letra mayúscula, una minúscula, un número y un caracter especial.\n";
                            }
                            return null;
                          },
                        ),
                      ),

                      // ----------- BUTTON REGISTER ------------

                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 30),
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
                                if (_formRegisterKey.currentState!.validate()) {
                                  DatabaseServices.registerUser(context: context, name: cName.text, lastName: cLastname.text, mail: cMail.text, 
                                  password: cPassword.text, age: DatabaseServices.calcularEdad(cBirthdate!), genere: cGender, birthDate: cBirthdate!);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Login()
                                      )
                                  );
                                }         
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
                  )
                ),

              ],
            ),

            Positioned(
                  top: 25,
                  left: 25,
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
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
                      width: 50,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Login()
                                  )
                              );
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.blueAccent,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

          ],
        )
        );
  }
}
