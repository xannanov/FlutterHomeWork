import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/ui/camera/Camera.dart';
import 'package:namer_app/ui/currency/CurrencyPage.dart';
import 'package:namer_app/ui/currency/CurrencyViewModel.dart';
import 'package:namer_app/ui/favorites/FavoritesPageViewModel.dart';
import 'package:namer_app/ui/generator/GeneratorPageViewModel.dart';
import 'package:namer_app/ui/weather/WeatherViewModel.dart';
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
        ChangeNotifierProvider(create: (_) => CurrencyViewModel()),
        ChangeNotifierProvider(create: (_) => MyAppState()),
      ],
      child: MaterialApp(
        title: 'Test App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
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
        // Provider.of<WeatherViewModel>(context).fetchWeatherData();
        // page = WeatherWidget();
        // break;
        Provider.of<CurrencyViewModel>(context).fetchCurrencyData();
        page = CurrencyPage();
        print("Currecy");
        break;
      case 1:
        page = CameraWidget(
          camera: widget.camera,
        );
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
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on),
              label: "Currency",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: "Camera",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Generator",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favorites",
            ),
          ],
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.black,
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
        ),
        body: Row(
          children: [
            Container(
              width: constraints.maxWidth,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ),
          ],
        ),
      );
    });
  }
}

var carList = [
  "BMW iX M60",
  "BMW i7",
  "BMW X7",
  "BMW 3 series",
  "BMW 2 series",
  "BMW iX M60",
  "BMW X6",
  "BMW X1"
];

class MyAppState extends ChangeNotifier {

  var current = carList[Random().nextInt(carList.length)];

  void getNext() {
    while (favorites.contains(current)) {
      current = carList[Random().nextInt(carList.length)];
    }
    notifyListeners();
  }

  var favorites = <String>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}
