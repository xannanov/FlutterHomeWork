import '../local/DriftDatabase.dart';
import '../local/model/Favorite.dart';

class FavoriteRepository {
  var nDatabase = DDatabase.db;

  Future<void> addFavorite(Favorite favorite) async {
    await nDatabase
        .into(nDatabase.favoritesTable)
        .insert(FavoritesTableCompanion.insert(word: favorite.word)).then((value) => print("int ${value}"));
  }

  Future<void> removeFavorite(Favorite favorite) async {
    await nDatabase.deleteFavorite(favorite);
  }

  Future<List<Favorite>> fetchFavorites() async {
    List<Favorite> result = [];
    var resp = await nDatabase.select(nDatabase.favoritesTable).get();
    for (var row in resp) {
      result.add(Favorite.idWord(row.id, row.word));
    }
    return result;
  }
}
