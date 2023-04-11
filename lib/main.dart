import 'package:camera/camera.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/ui/camera/Camera.dart';
import 'package:namer_app/ui/favorites/FavoritesPageViewModel.dart';
import 'package:namer_app/ui/generator/GeneratorPageViewModel.dart';
import 'package:namer_app/ui/weather/WeatherViewModel.dart';
import 'package:namer_app/ui/weather/WeatherPage.dart';
import 'package:provider/provider.dart';

import 'ui/favorites/FavoritesPage.dart';
import 'ui/generator/GeneratorPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();

  final camera = cameras.first;
  runApp(MyApp(
    camera: camera,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.camera});

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherViewModel()),
        ChangeNotifierProvider(create: (_) => GeneratorPageViewModel()),
        ChangeNotifierProvider(create: (_) => FavoritePageViewModel()),
        ChangeNotifierProvider(create: (_) => MyAppState()),
      ],
      child: MaterialApp(
        title: 'Test App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        ),
        home: MyHomePage(
          camera: camera,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = CameraWidget(camera: widget.camera,);
        break;
      case 1:
        Provider.of<WeatherViewModel>(context).fetchWeatherData();
        page = WeatherWidget();
        break;
      case 2:
        page = GeneratorPage();
        break;
      case 3:
        Provider.of<FavoritePageViewModel>(context).fetchFavoritesData();
        page = Favorites();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                      icon: Icon(Icons.camera),
                      label: Text('Camera')
                  ),
                  NavigationRailDestination(
                      icon: Icon(Icons.sunny),
                      label: Text('Weather')
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Generator'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Favorites'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}
