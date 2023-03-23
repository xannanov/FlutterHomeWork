import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/ui/generator/GeneratorPageViewModel.dart';
import 'package:provider/provider.dart';

import '../../data/local/model/Favorite.dart';
import '../../main.dart';

class GeneratorPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var generatorPageVm = context.watch<GeneratorPageViewModel>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  var word = "${pair.first.toLowerCase()}${pair.second.toLowerCase()}";
                  if (!appState.favorites.contains(pair)) {
                    generatorPageVm.addFavorite(Favorite.word(word));
                  } else {
                    generatorPageVm.removeFavorite(Favorite.word(word));
                  }
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
        color: theme.colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(pair.asLowerCase,
              style: style, semanticsLabel: "${pair.first} ${pair.second}"),
        ));
  }
}