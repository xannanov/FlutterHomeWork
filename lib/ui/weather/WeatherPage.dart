import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:namer_app/data/network/api_response.dart';
import 'package:namer_app/ui/weather/WeatherViewModel.dart';
import 'package:provider/provider.dart';

import '../../data/repository/model/Weather.dart';

class WeatherWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var weathers = context.watch<WeatherViewModel>();

    if (weathers.response.status == Status.ERROR) {
      return Center(
        child: Text('Can`t load data about cities')
      );
    } else if (weathers.response.status == Status.LOADING) {
      return Center(
          child: SpinKitWave(
            color: Colors.white,
            size: 50.0,)
      );
    }

    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Text('Weather'),
        ),
        for (var city in weathers.response.data as List<Weather>)
          ListTile(
            leading: Icon(Icons.wb_sunny_sharp),
            title: Text("${city.name} ${city.tempF}℉"),
            subtitle: Text("${city.weatherDesc}. Window speed is ${city.windSpeed}"),
          ),
      ],
    );
  }
}