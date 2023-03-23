import '../local/Database.dart';
import '../local/model/Favorite.dart';

class FavoriteRepository {
  var database = DBProvider.db;

  Future<void> addFavorite(Favorite favorite) async {
    await database.newFavorite(favorite);
  }

  Future<void> removeFavorite(Favorite favorite) async {
    await database.deleteFavoriteByWord(favorite.word);
  }

  Future<List<Favorite>> fetchFavorites() async {
    List<Favorite> result = [];
    var resp = await database.getAllFavorites();
    result.addAll(resp);
    return result;
  }
}