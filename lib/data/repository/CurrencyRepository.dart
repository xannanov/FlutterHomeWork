import 'dart:convert';
import 'package:namer_app/data/repository/MediaService.dart';
import 'package:namer_app/data/repository/model/Currency.dart';
import 'package:namer_app/data/repository/model/Weather.dart';

class CurrencyRepository {
  MediaService _mediaService = MediaService();

  String url = "https://currate.ru/api/?get=rates&pairs=USDRUB,EURRUB,BTCRUB,JPYRUB,GBPRUB,BYNRUB,CNYRUB,XRPRUB,THBRUB,CADRUB&key=0850201920c3aded53788500c9e840c6";

  Future<Currency> fetchCurrentCurrency() async {
    dynamic resp = await _mediaService.getResponse(url);
    return Currency.fromJson(resp);
  }
}