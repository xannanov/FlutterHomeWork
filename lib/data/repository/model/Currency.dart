import 'dart:core';

class Currency {
  final String? name;
  final Map<String, String> cur;

  Currency(
      {
        this.name,
        required this.cur,
      });


  factory Currency.fromJson(Map<String, dynamic> map) {
    return Currency(
      name: "RUB",
      cur: {
        "USD": map['data']['USDRUB'] as String,
        "EUR": map['data']['EURRUB'] as String,
        "BTC": map['data']['BTCRUB'] as String,
        "JPY": map['data']['JPYRUB'] as String,
        "GBR": map['data']['GBPRUB'] as String,
        "BYN": map['data']['BYNRUB'] as String,
        "CNY": map['data']['CNYRUB'] as String,
        "XRP": map['data']['XRPRUB'] as String,
        "THB": map['data']['THBRUB'] as String,
        "CAD": map['data']['CADRUB'] as String,
      }
    );
  }
}