import 'dart:typed_data';
import 'package:backend/database.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mysql1/mysql1.dart';


Future<Response> onRequest(RequestContext context) async {
  final conn = await connectToDatabase();
  var results = await conn.query('SELECT idproducto, nombre, codigo, imagen FROM productos');

  List<Map<String, dynamic>> productos = results.map((row) {
    Uint8List? imagenBytes;

    if (row[3] != null) {
      final blobData = row[3];
      if (blobData is Blob) {
        imagenBytes = Uint8List.fromList(blobData.toBytes());
      } else if (blobData is List<int>) {
        imagenBytes = Uint8List.fromList(blobData);
      }
    }

    return {
      'id': row[0],
      'nombre': row[1],
      'codigo': row[2],
      'imagen': imagenBytes,
    };
  }).toList();

  await conn.close();
  return Response.json(body: productos);
}
