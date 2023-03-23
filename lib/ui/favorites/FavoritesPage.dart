import 'package:flutter/material.dart';
import 'package:namer_app/ui/favorites/FavoritesPageViewModel.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var favoritesVm = context.watch<FavoritePageViewModel>();

    if (favoritesVm.favorites.isEmpty) {
      return Center(
        child: Text("No favorites yet"),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Text('You have ${favoritesVm.favorites.length} favorites:'),
        ),
        for (var favorite in favoritesVm.favorites)
          ListTile(
              leading: Icon(Icons.favorite), title: Text(favorite.word.toLowerCase())),
      ],
    );
  }
}
