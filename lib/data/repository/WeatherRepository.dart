import 'dart:convert';
import 'package:namer_app/data/repository/MediaService.dart';
import 'package:namer_app/data/repository/model/Weather.dart';

class WeatherRepository {
  MediaService _mediaService = MediaService();

  List<String> citiesCoords = [
    'lat=55,7887&lon=49,1221',
    'lat=56.000000&lon=54.733334',
    'lat=55.751244&lon=37.618423',
    'lat=47.751076&lon=-120.740135',
    'lat=43.000000&lon=-73.935242',
    'lat=-22.908333&lon=-43.196388',
    'lat=41.739685&lon=-87.554420',
    'lat=55.676098&lon=12.568337',
    'lat=41.902782&lon=12.496366',
    'lat=41.390205&lon=2.154007',
    'lat=40.416775&lon=-3.703790',
    'lat=51.509865&lon=0.118092',
    'lat=0&lon=0',
    'lat=48.864716&lon=2.349014',
    'lat=57.9214912&lon=59.9816186',
  ];

  Future<List<Weather>> fetchCurrentWeatherList() async {
    List<Weather> result = [];
    for (var city in citiesCoords) {
      dynamic response = await _mediaService.getResponse(city);
      result.add(Weather.fromJson(response));
    }
    return result;
  }
}