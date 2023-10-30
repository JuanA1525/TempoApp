import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:tempo_app/pages/login.dart';
import 'package:flutter_svg/flutter_svg.dart';



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
                  child: const Center(
                      child: Text('Tempo',
                      maxLines: 3,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ),
                ),
              ),
                


              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text('Your personal time tracker',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ),

            ],
          ),


          // ----------- BUTTON Home ------------
              
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 836),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
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