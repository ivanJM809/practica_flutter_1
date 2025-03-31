
import 'package:mysql1/mysql1.dart';

Future<MySqlConnection> connectToDatabase() async {
  final settings = ConnectionSettings(
    host: 'localhost',     
    port: 3306,            
    user: 'root',         
    password: '885551',  
    db: 'ivanddbb',  
  );

  return await MySqlConnection.connect(settings);
}
