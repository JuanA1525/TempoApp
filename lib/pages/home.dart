import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:tempo_app/pages/login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tempo_app/pages/dialog_helper.dart';



class Home extends StatelessWidget {
  const Home({super.key});

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

              const SizedBox(height: 150,),


              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.transparent,
                  child: const Column(
                    children: [

                         Center(
                          child: Text('Bienvenido!',
                          maxLines: 3,
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 160, 240),
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Color.fromARGB(98, 0, 0, 0),
                                  offset: Offset(2, 2), // Desplazamiento en x y y
                                  blurRadius: 5, // Radio de difuminación
                                ),
                              ],
                            ),
                            
                          )
                        ),

                        Center(
                          child: Text('@Username',
                          maxLines: 3,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ),

                    ],
                  ),
                ),
              ),
                


              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: const Text("No te vas a arrepentir de usar Tempo y manejar tu tiempo!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ),
              

              const SizedBox(height: 50,),
              
              Image.asset(
              'assets/temp_clock.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),

            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 50),
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
                height: 60,
                width: 160,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Comencemos",
                        maxLines: 3,
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.blueAccent, size: 30,),
                      ],
                    )
                  ),
                ),
              ),
            )

            ],
          ),


          // ----------- BUTTON Home ------------
              
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  decoration: BoxDecoration(
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
                  height: 60,
                  width: 414,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
                        },
                        child: SvgPicture.asset(
                          'assets/task_icon.svg', 
                          color: Colors.blueAccent,
                          width: 30,
                          height: 30,
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
                        },
                        child: const Icon(Icons.punch_clock, color: Colors.blueAccent, size: 30,),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
                        },
                        child: const Icon(Icons.home, color: Colors.blueAccent, size: 30,),
                      ),

                      GestureDetector(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
                          DialogHelper.showPopUpRegisterDataError(context, "\nEl correo no tiene un formato valido.\nLa contraseña debe ser de minimo 8 caracteres.");
                        },
                        child: const Icon(Icons.bed, color: Colors.blueAccent, size: 30,),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
                        },
                        child: const Icon(Icons.person, color: Colors.blueAccent, size: 30,),
                      ),

                    ],
                  ),
                ),
              ),


        ],
      )
    );
  }


  

}