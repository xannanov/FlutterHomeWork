import 'package:flutter/cupertino.dart';
import 'package:namer_app/data/network/api_response.dart';
import 'package:namer_app/data/repository/WeatherRepository.dart';

import '../../data/repository/model/Weather.dart';

class WeatherViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.loading('load cities');
  
  Weather? _weather;
  
  ApiResponse get response {
    return _apiResponse;
  }
  
  Weather? get weather {
    return _weather;
  }

  bool isResponseEmpty() {
    if (_apiResponse.data == null) return true;
    return (_apiResponse.data as List<Weather>).isEmpty;
  }
  
  Future<void> fetchWeatherData() async {
    if (!isResponseEmpty()) {
      return;
    }

    _apiResponse = ApiResponse.loading('Fetching weather data');
    try {
      List<Weather> weather = await WeatherRepository().fetchCurrentWeatherList();
      _apiResponse = ApiResponse.completed(weather);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }
}