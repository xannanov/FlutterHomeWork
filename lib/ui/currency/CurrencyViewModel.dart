import 'package:flutter/cupertino.dart';
import 'package:namer_app/data/network/api_response.dart';
import 'package:namer_app/data/repository/CurrencyRepository.dart';
import 'package:namer_app/data/repository/WeatherRepository.dart';
import 'package:namer_app/data/repository/model/Currency.dart';

import '../../data/repository/model/Weather.dart';

class CurrencyViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.loading('load cities');

  ApiResponse get response {
    return _apiResponse;
  }

  Currency get currency {
    return _apiResponse.data as Currency;
  }

  bool isResponseEmpty() {
    return _apiResponse.data == null;
  }

  Future<void> fetchCurrencyData() async {
    if (!isResponseEmpty()) {
      return;
    }

    _apiResponse = ApiResponse.loading('Fetching weather data');
    try {
      Currency currency = await CurrencyRepository().fetchCurrentCurrency();
      print(currency);
      _apiResponse = ApiResponse.completed(currency);
    } catch (e) {
      _apiResponse = ApiResponse.completed(
          Currency(name: "", cur: {}
          ));
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }
}
