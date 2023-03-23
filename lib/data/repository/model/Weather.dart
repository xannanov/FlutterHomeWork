import 'dart:core';

class Weather {
  final String? name;
  final String? weatherDesc;
  final double? windSpeed;
  final double? tempF;

  Weather(
      {this.name,
        this.weatherDesc,
        this.windSpeed,
        this.tempF,});


  factory Weather.fromJson(Map<String, dynamic> map) {
    return Weather(
      name: map['name'] as String?,
      weatherDesc: map['weather'][0]['description'] as String?,
      windSpeed: map['wind']['speed'] as double?,
      tempF: map['main']['temp'] as double?,
    );
  }
}