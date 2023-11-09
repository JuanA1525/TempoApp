import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tempo_app/pages/home.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {


  final _formKey = GlobalKey<FormState>();
  final _tasks = <String>[];

  TextEditingController _taskController = TextEditingController();

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
                      'Mis tareas:',
                      maxLines: 3,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),


              // Resto del contenido de la pantalla Tasks
              Container(
                margin: EdgeInsets.all(25),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                
                ),
                child: Column(
                  children: [

                    
                    Form(
                      key: _formKey,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _taskController, // Asigna el controlador aquí
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Ejemplo: Sacar a pasear al perro...',
                                hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 60, 60, 60),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor ingresa una tarea!';
                                }
                                return null;
                              },
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _tasks.add(_taskController.text); // Obtiene el valor del controlador
                                  _taskController.clear(); // Borra el valor del controlador
                                });
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.blue),
                              shape: MaterialStateProperty.all(CircleBorder()),
                            ),
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )

                    
                  ],
                ),
              ),

              

              Container(
                margin: EdgeInsets.only(left: 25),
                child: const Text(
                  "Lista de tareas:",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),

              Container(
                width: 400,
                margin: EdgeInsets.only(top: 20),
                child: ListView.builder(
                  shrinkWrap: true, // Para que el ListView.builder se ajuste al contenido
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    if(_tasks.isEmpty){
                        
                      return Text("Aun no hay tareas");
                    

                    }else{
                      return Container(
                        margin: EdgeInsets.only(right: 30, left: 30, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        
                        ),
                        child: ListTile(
                          title: Text(_tasks[index]),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.blueAccent),
                            onPressed: () {
                              setState(() {
                                _tasks.removeAt(index);
                              });
                            },
                          ),
                        ),
                      );
                    }
                    
                  },
                ),
              ),

            ],
          ),

          Home.navbar(context),

        ],
      ),
    );
  }
}
