import 'package:drift/web.dart';
// ignore: avoid_web_libraries_in_flutter
import '../DriftDatabase.dart';

const _useWorker = true;

DDatabase constructDb() {
  return DDatabase(WebDatabase('db'));
}