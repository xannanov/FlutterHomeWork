import 'package:drift/web.dart';
// ignore: avoid_web_libraries_in_flutter
import '../DriftDatabase.dart';

DDatabase constructDb() {
  return DDatabase(WebDatabase('db'));
}