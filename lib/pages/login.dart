import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:tempo_app/pages/home.dart';
import 'package:tempo_app/pages/register.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF352BFF),
      body: Stack(
        children: [
          // Fondo de imagen
            Image.asset(
              'assets/login_bg.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),

            // ListView superpuesto
          ListView(
            children: [

              const SizedBox(height: 150,),


              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(
                        child: Text('Tempo',
                        maxLines: 3,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ),

                      Image.asset(
                        'assets/temp_clock.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      ),

                    ],
                  ),
                ),
              ),
                


              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text('Tu plataforma de gestión de tiempo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ),

              const SizedBox(height: 100,),

              // ----------- TEXT LOGIN ------------

              Container(
                margin: const EdgeInsets.only(left: 30),
                child: const Text('Iniciar Sesión',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  )
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
                      offset: const Offset(0, 3)
                    )
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Correo electrónico',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                    ),
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
                      offset: const Offset(0, 3)
                    )
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Contraseña',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                    ),
                  ),
                ),
              ),

              // ----------- NOT REGISTERED ------------

              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Register()));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Aun no estas registrado? Crea una cuenta',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
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
                    boxShadow:[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3)
                      )
                    ],
                  ),
                  height: 50,
                  width: 100,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
                      },
                      child: const Icon(Icons.arrow_forward_ios, color: Colors.blueAccent, size: 30,),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      )
    );
  }
}