import '../local/Database.dart';
import '../local/DriftDatabase.dart';
import '../local/model/Favorite.dart';

class FavoriteRepository {
  var database = DBProvider.db;
  var nDatabase = DDatabase.db;

  Future<void> addFavorite(Favorite favorite) async {
    await nDatabase
        .into(nDatabase.favoritesTable)
        .insert(FavoritesTableCompanion.insert(word: favorite.word)).then((value) => print("int ${value}"));
    // await database.newFavorite(favorite);
  }

  Future<void> removeFavorite(Favorite favorite) async {
    await nDatabase.deleteFavorite(favorite);
    // await database.deleteFavoriteByWord(favorite.word);
  }

  Future<List<Favorite>> fetchFavorites() async {
    List<Favorite> result = [];
    var resp = await nDatabase.select(nDatabase.favoritesTable).get();
    for (var row in resp) {
      result.add(Favorite.idWord(row.id, row.word));
    }
    // var resp = await database.getAllFavorites();
    // result.addAll(resp);
    return result;
  }
}
