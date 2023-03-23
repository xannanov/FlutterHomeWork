import 'package:flutter/foundation.dart';
import 'package:namer_app/data/repository/FavoritesRepository.dart';

import '../../data/local/model/Favorite.dart';

class GeneratorPageViewModel with ChangeNotifier {
  Future<void> addFavorite(Favorite favorite) async {
    await FavoriteRepository().addFavorite(favorite);
  }
  Future<void> removeFavorite(Favorite favorite) async {
    await FavoriteRepository().removeFavorite(favorite);
  }
}