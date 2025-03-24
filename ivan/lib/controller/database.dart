import 'package:mysql1/mysql1.dart';

class Database {
  
  final String _host = 'localhost';
  final int _port = 3306;
  final String _password = '885551';
  final String _user = 'root';

  // Métodos
  instalacion() async {
    var settings = ConnectionSettings(
      host: _host,
      port: _port,
      user: _user,
      password: _password,
    );
    var conn = await MySqlConnection.connect(settings);
    try{
      await _crearDB(conn);
      await _crearTablaUsuarios(conn);
      await _crearTablaProductos(conn);
      await conn.close();
    } catch(e){
      print(e);
      await conn.close();
    }
  }

  Future<MySqlConnection> conexion() async {
    var settings = ConnectionSettings(
      host: _host,
      port: _port,
      user: _user,
      password: _password,
      db: 'ivanddbb'
    );
     
    return await MySqlConnection.connect(settings);
 
  }
 
  _crearDB (conn) async {
    await conn.query('CREATE DATABASE IF NOT EXISTS ivanddbb');
    await conn.query('USE ivanddbb');
    print('Conectado a ivanddbb');
  }

  _crearTablaUsuarios(conn) async {
    await conn.query('''CREATE TABLE IF NOT EXISTS usuarios(
        idusuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(50) NOT NULL UNIQUE,
        password VARCHAR(10) NOT NULL
    )''');
    print('Tabla usuarios creada');
  }

  _crearTablaProductos(conn) async {
    await conn.query('''CREATE TABLE IF NOT EXISTS productos(
        idproducto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(50) NOT NULL,
        codigo VARCHAR(10) NOT NULL UNIQUE,
        imagen blob NOT NULL,
         FOREIGN KEY(idusuario) REFERENCES usuarios(idusuario)
    )''');
    print('Tabla productos creada');
  }
   
}