import 'package:flutter/material.dart';
import 'package:ivan/buscarProductosScreen.dart';
import 'package:ivan/catalogoScreen.dart';
import 'package:ivan/homeScreen.dart';
import 'package:ivan/ingresarScreen.dart';
import 'package:ivan/loginScreen.dart';
import 'package:ivan/redesSociales.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      
      initialRoute: '/ruta_inicio', 
      routes: {
        '/ruta_inicio': (context) => LoginScreen(), 
        '/home': (context) => Homescreen(), 
        '/catalogo' : (context) => CatalogoScreen(),
        '/redes' : (context) => RedesScreen(),
        '/ingresar_producto' : (context) => IngresarProductoScreen(),
        '/buscarProductos' : (context) => BuscarProductosScreen(),
      },
    );
  }
}

   