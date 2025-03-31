import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://localhost:8080/productos'; // Ajusta el puerto si es diferente

  static Future<List<Map<String, dynamic>>> fetchProductos() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((item) {
          return {
            'idproducto': item['idproducto'],
            'nombre': item['nombre'],
            'codigo': item['codigo'],
            // Cambié base64Decode por la conversión adecuada de la lista de bytes
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
