import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Menú',
        style: TextStyle(
          fontFamily: 'permanent_marker',
          fontSize: 40,
        ),
 ),
        centerTitle: true,
        leadingWidth: 70,
        backgroundColor: Colors.blue,
        elevation: 20,
        shadowColor: Colors.black.withOpacity(0.5),
        actions: [
          PopupMenuButton(itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: Text('perfil'),
                value: 'perfil',
              ),
              PopupMenuItem(
                child: Text('Configuracion'),
                value: 'configuracion',
              ),
              PopupMenuItem(
                child: Text('Informacion nuestra'),
                value: 'informacion nuestra',
              ),
            ];
          }, onSelected: (String value){
            if(value == 'perfil'){
              Navigator.pushNamed(context, '/perfil');
            } else if(value == 'configuracion'){
              Navigator.pushNamed(context, '/configuracion');
            }else if(value == 'informacion nuestra'){
              Navigator.pushNamed(context, '/informacion');
            }
          },
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 201, 200, 200),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fondo.jpg"),
            fit: BoxFit.cover, 
          ),
        ),
      
      
      
       child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            margin: const EdgeInsets.only(
              top: 200,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(110, 3, 168, 244)
            ),
            child: Column(
              children: [
                Text('Catálogo',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'permanent_marker',
                ),
                textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text('Conoce nuestros productos',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'indie_flower',
                ),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 50),
                  backgroundColor: const Color.fromARGB(255, 218, 114, 149),
                  ),
                  onPressed: (){
                    Navigator.pushNamed(context, '/catalogo');
                  },
                  child: Text('Ver catálogo',
                  style: TextStyle(
                    fontFamily: 'permanent_marker',
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                margin: const EdgeInsets.only(
                  top: 200,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(110, 3, 168, 244)
                ),
                child: Column(
                  children: [
                    Text('Contacto',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'permanent_marker',
                    ),
                    ),
                    SizedBox(height: 10),
                    Text('Conoce mas de nosotros en redes sociales',
                    style: TextStyle(
                      fontFamily: 'indie_flower',
                      fontSize: 20,
                    ),
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 50),
                  backgroundColor: const Color.fromARGB(255, 218, 114, 149),
                  ),
                  onPressed: (){
                    Navigator.pushNamed(context, '/redes');
                  },
                  child: Text('Social media',
                  style: TextStyle(
                    fontFamily: 'permanent_marker',
                    ),
                  ),
                ),
                  ],
                ),
              ),
            ],
          ),
        ],
       ),
     ),
  );
  }
}

