import 'package:flutter/material.dart';
import 'homeScreen.dart'; 


class LoginScreen extends StatefulWidget {
  const  LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Con este metodo compruebo los campos
   checkCampos() {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gracias')),
      );
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()), 
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, ingrese ambos campos')),
      );
    }
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 70,
          title: Text(
            'App Ivan',
            style: TextStyle(
              fontFamily: 'permanent_marker',
              fontSize: 40,
            ),
            ),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/images/avatar.jpg'),
          ),
          elevation: 10, 
        shadowColor: Colors.black.withOpacity(0.5),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color.fromARGB(255, 154, 204, 228),
            ),
            margin: const EdgeInsets.only(
              top: 100.0, 
              left: 500.0),

            height: 270,
            width: 1000,
            child: Column(
              children: [
                Text(
                  'Inicio de sesión',
                  style: TextStyle(
                    fontFamily: 'permanent_marker',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text('Correo electrónico', 
                style: TextStyle(
                  fontFamily: 'indie_flower',
                  fontSize: 20)),
                SizedBox(height: 5),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.email, color: Colors.blue),
                    border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Correo electrónico',
                  ),
                ),
                SizedBox(height: 5),
                Text('Contraseña',
                 style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'indie_flower',
                  )),
                SizedBox(height: 5),
                TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.visibility, color: Colors.blue),
                    border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Contraseña',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: checkCampos,
                  child: Text(
                    'Aceptar',
                    style: TextStyle(
                      fontFamily: 'indie_flower', ),
                    ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
