import 'dart:typed_data';
import 'package:mysql1/mysql1.dart';
import '../../controller/database.dart';

class Producto {
  int? _idproducto;
  String? _nombre;
  String? _codigo;
  Uint8List? _imagen;

  // Constructor
  Producto({
    int? idproducto,
    String? nombre,
    String? codigo,
    Uint8List? imagen,
  })  : _idproducto = idproducto,
        _nombre = nombre,
        _codigo = codigo,
        _imagen = imagen;

  Producto.fromMap(Map<String, dynamic> map) {
    _idproducto = map["idproducto"];
    _nombre = map["nombre"];
    _codigo = map["codigo"];

    // Aquí se convierte el Blob a Uint8List
    var blobData = map["imagen"];
    if (blobData is Blob) {
      _imagen = Uint8List.fromList(blobData.toBytes());
    } else if (blobData is Uint8List) {
      _imagen = blobData;
    }
  }

  // Método fromJson para conversión desde JSON
  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      idproducto: json['idproducto'],
      nombre: json['nombre'] ?? 'Sin nombre',
      codigo: json['codigo'] ?? 'Sin código',
      imagen: json['imagen'] != null ? Uint8List.fromList(List<int>.from(json['imagen'])) : null,
    );
  }

  // Getters y Setters
  String? get nombre => _nombre;
  set nombre(String? texto) => _nombre = texto;

  String? get codigo => _codigo;
  set codigo(String? texto) => _codigo = texto;

  int? get idproducto => _idproducto;
  set idproducto(int? numero) => _idproducto = numero;

  Uint8List? get imagen => _imagen;
  set imagen(Uint8List? value) => _imagen = value;

  // Insertar producto en la base de datos
  insertarProducto() async {
    var conn = await Database().conexion();
    try {
      await conn.query(
        "INSERT INTO productos(idproducto, nombre, codigo, imagen) VALUES (?, ?, ?, ?)",
        [_idproducto, _nombre, _codigo, _imagen],
      );
      print("Producto insertado correctamente");
    } catch (e) {
      print("Error al insertar el producto: $e");
    } finally {
      await conn.close();
    }
  }

  // Obtener todos los productos
  /*Future<List<Producto>> obtenerProductosRegistrados() async {
    var conn = await Database().conexion();
    try {
      var listado = await conn.query("SELECT * FROM productos");
      List<Producto> productos = listado.map((row) => Producto.fromMap(row.fields)).toList();
      return productos;
    } catch (e) {
      print(e);
      return [];
    } finally {
      await conn.close();
    }
  }*/

  // Buscar productos por nombre
 /* Future<List<Producto>> buscarProductosPorNombre(String query) async {
    var conn = await Database().conexion();
    try {
      var listado = await conn.query(
        "SELECT * FROM productos WHERE nombre LIKE ?",
        ['%$query%'],
      );
      List<Producto> productos = listado.map((row) => Producto.fromMap(row.fields)).toList();
      return productos;
    } catch (e) {
      print("Error al buscar el producto: $e");
      return [];
    } finally {
      await conn.close();
    }
  }*/
}
