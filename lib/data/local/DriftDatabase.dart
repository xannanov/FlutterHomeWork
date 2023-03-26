import 'package:drift/drift.dart';

import 'connection/connection.dart' as impl;
import 'model/Favorite.dart';

// assuming that your file is called filename.dart. This will give an error at
// first, but it's needed for drift to know about the generated code
part 'DriftDatabase.g.dart';

class FavoritesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get word => text()();
}

@DriftDatabase(tables: [FavoritesTable])
class DDatabase extends _$DDatabase {
  DDatabase(QueryExecutor e) : super(e);

  static final DDatabase db = impl.constructDb();

  @override
  int get schemaVersion => 1;

  Future<int> deleteFavorite(Favorite favorite) async {
    return await (delete(favoritesTable)..where((tbl) => tbl.word.equals(favorite.word))).go();
  }
}