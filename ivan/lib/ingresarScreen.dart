import 'package:flutter/material.dart';
import 'package:ivan/model/producto.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'dart:io';


class IngresarProductoScreen extends StatefulWidget {
  @override
  _IngresarProductoScreenState createState() => _IngresarProductoScreenState();
}

class _IngresarProductoScreenState extends State<IngresarProductoScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _codigoController = TextEditingController();
  Uint8List? _imagenBytes;


  Future<void> _seleccionarImagen() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowMultiple: false,
  );

  if (result != null && result.files.isNotEmpty) {
  
    final filePath = result.files.first.path;

    if (filePath != null) {
      final fileBytes = await File(filePath).readAsBytes();
      
      setState(() {
        _imagenBytes = fileBytes; 
      });
    }
  }
}


  Future<void> _guardarProducto() async {
    if (_formKey.currentState!.validate() && _imagenBytes != null) {
      Producto nuevoProducto = Producto()
        ..idproducto = 0
        ..nombre = _nombreController.text
        ..codigo = _codigoController.text
        ..imagen = _imagenBytes; 

      await nuevoProducto.insertarProducto();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Producto agregado exitosamente')),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos y selecciona una imagen')),
      );
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back),
      ),
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text(
        'Ingresar Producto',
        style: TextStyle(
          fontFamily: 'permanent_marker',
          fontSize: 30,
        ),
      ),
    ),
    body: Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/fondo3.jpg', 
            fit: BoxFit.cover,
          ),
        ),
        
        
        Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(200, 154, 204, 228),
            ),
            margin: EdgeInsets.all(50), 
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nombreController,
                      decoration: InputDecoration(labelText: 'Nombre'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, pon un nombre';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _codigoController,
                      decoration: InputDecoration(labelText: 'Código'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, pon el código';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _seleccionarImagen,
                      child: Text(
                        'Seleccionar Imagen',
                        style: TextStyle(
                          fontFamily: 'permanent_marker',
                          fontSize: 13,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _imagenBytes != null
                        ? Image.memory(_imagenBytes!, height: 200)
                        : Text('No se ha seleccionado ninguna imagen'),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _guardarProducto,
                      child: Text(
                        'Guardar Producto',
                        style: TextStyle(
                          fontFamily: 'permanent_marker',
                          fontSize: 20,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(200, 50),
                        backgroundColor: const Color.fromARGB(255, 218, 114, 149),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
