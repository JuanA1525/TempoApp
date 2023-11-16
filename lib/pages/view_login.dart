// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tempo_app/Service/database_services.dart';
import 'package:tempo_app/pages/dialog_helper.dart';
import 'dart:ui';
import 'package:tempo_app/pages/view_register.dart';

import 'view_home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formLoginKey = GlobalKey<FormState>();

  final TextEditingController cMail = TextEditingController();
  final TextEditingController cPassword = TextEditingController();

  final RegExp vMail =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF352BFF),
        body: Stack(
          children: [
            Image.asset(
              'assets/login_bg.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                            child: Text(
                          'Tempo',
                          maxLines: 3,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 45,
                              fontWeight: FontWeight.bold),
                        )),
                        Image.asset(
                          'assets/temp_clock.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
            
                  Center(
                      child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: const Text(
                      'Tu plataforma de gestión de tiempo',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            
                  const SizedBox(
                    height: 100,
                  ),
            
                  // ----------- TEXT LOGIN ------------
            
                  Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: const Text(
                        'Iniciar Sesión',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )),
            
                  Form(
                    key: _formLoginKey,
                    child: Column(
                      children: [
                        // ----------- INPUT EMAIL ------------
            
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10, left: 30, right: 30),
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
                              if (value!.isNotEmpty) {
                                if (!vMail.hasMatch(value)) {
                                  return 'Por favor ingrese un correo electrónico válido';
                                }
                              } else {
                                return 'Por favor ingrese su correo electrónico';
                              }
                              return null;
                            },
                          ),
                        ),
            
                        // ----------- INPUT PASSWORD ------------
            
                        Container(
                          margin:
                              const EdgeInsets.only(top: 10, left: 30, right: 30),
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
                            controller: cPassword,
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Contraseña',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Por favor ingrese su contraseña';
                              }
                              return null;
                            },
                          ),
                        ),
            
                        // ----------- NOT REGISTERED ------------
            
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Register()));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 10, left: 30, right: 30),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Aun no estas registrado? Crea una cuenta',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
            
                        // ----------- BUTTON LOGIN ------------
            
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              if (_formLoginKey.currentState!.validate()) {
                                final success = await DatabaseServices.login(
                                    mail: cMail.text, password: cPassword.text);
            
                                if (success) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Home()),
                                  );
                                } else {
                                  DialogHelper.showPopUpLoginDataError(context,
                                      "Error en la contraseña o en el correo electrónico");
                                }
            
                                cMail.clear();
                                cPassword.clear();
                              }
                            },
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
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.blueAccent,
                                size: 30,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
