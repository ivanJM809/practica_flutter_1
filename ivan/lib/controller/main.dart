import 'database.dart';

Future<void> main() async {
  print(' Iniciando aplicación...');
  await Database().instalacion();
  print(' Base de datos lista');
}
