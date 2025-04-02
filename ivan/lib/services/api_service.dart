import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://localhost:8080/productos'; //Url del endpoint de mi API

  static Future<List<Map<String, dynamic>>> buscarProductos() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((item) {
          return {
            'idproducto': item['idproducto'],
            'nombre': item['nombre'],
            'codigo': item['codigo'],
            // convesrsion de la imagen a Uint8List
            'imagen': item['imagen'] != null
                ? Uint8List.fromList(List<int>.from(item['imagen']))
                : null,
          };
        }).toList();
      } else {
        throw Exception('Error al obtener los productos: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la petición: $e');
      return [];
    }
  }
}
