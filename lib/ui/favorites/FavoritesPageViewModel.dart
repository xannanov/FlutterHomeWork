import 'package:flutter/foundation.dart';

import '../../data/local/model/Favorite.dart';
import '../../data/repository/FavoritesRepository.dart';
import 'package:collection/collection.dart';

class FavoritePageViewModel with ChangeNotifier {
  List<Favorite>? _favorites;

  List<Favorite> get favorites {
    return _favorites ?? [];
  }

  Future<void> fetchFavoritesData() async {
    List<Favorite> favorites = await FavoriteRepository().fetchFavorites();
    if (!ListEquality().equals(_favorites, favorites)) {
      _favorites = favorites;
      notifyListeners();
    }
  }
}