import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:namer_app/data/local/DriftDatabase.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

DDatabase constructDb() {
  final db = LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
  return DDatabase(db);
}