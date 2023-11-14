import 'package:flutter/material.dart';
import 'package:tempo_app/Service/database_services.dart';
import 'package:tempo_app/enum/priority.dart';
import 'package:tempo_app/enum/state.dart';
import 'package:tempo_app/model/model_custom_user.dart';
import 'dart:ui';
import 'package:tempo_app/pages/sleeps.dart';
import 'package:tempo_app/pages/view_login.dart';
import 'package:tempo_app/pages/view_tasks.dart';



class Home extends StatelessWidget {
  const Home({super.key});

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
            
            
          Container(
            color: const Color.fromARGB(112, 0, 49, 90),
            child: ListView(
              children: [
          
                const SizedBox(height: 150,),
          
          
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Column(
                    children: [
          
                         const Center(
                          child: Text('Bienvenido!',
                          maxLines: 3,
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Color.fromARGB(205, 0, 0, 0),
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                            
                          )
                        ),
          
                        Center(
                          child: Text("${CustomUser.usuarioActual!.name} ${CustomUser.usuarioActual!.lastName}",
                          maxLines: 3,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ),
          
                    ],
                  ),
                ),
                  
          
          
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
                    padding: const EdgeInsets.only(left: 35, right: 35),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Tasks()));
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
          ),


          // ----------- BUTTON Home ------------
              
              navbar(context),


        ],
      )
    );
  }

  static Positioned navbar(BuildContext context) {
    return Positioned(
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
                height: 70,
                width: 414,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Tasks()));
                      },
                      // child: SvgPicture.asset(
                      //   'assets/task_icon.svg', 
                      //   color: Colors.blueAccent,
                      //   width: 32,
                      //   height: 32,
                      // ),
                      child: const Icon(Icons.task_alt_outlined, color: Colors.blueAccent, size: 32,),
                    ),

                    GestureDetector(
                      onTap: () {
                        DatabaseServices.addTask(name: "Nombre de Task", description: "descriptionTEST", priority: ePriority.high, state: eState.toDo, duration: 12);
                      },
                      child: const Icon(Icons.timer_sharp, color: Colors.blueAccent, size: 32,),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
                      },
                      child: const Icon(Icons.home_outlined, color: Colors.blueAccent, size: 32,),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Sleeps()));
                      },
                      child: const Icon(Icons.bed_outlined, color: Colors.blueAccent, size: 32,),
                    ),

                    GestureDetector(
                      onTap: () {

                        if(DatabaseServices.logout()){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
                        }
                        
                      },
                      child: const Icon(Icons.person_outline, color: Colors.blueAccent, size: 32,),
                    ),

                  ],
                ),
              ),
            );
  }


  

}