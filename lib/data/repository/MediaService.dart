import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../network/app_exception.dart';

class MediaService {
  final String _baseUrl = "https://api.openweathermap.org/data/2.5/weather?appid=84d5da044ccf9ca9af58e9fb8867ece8&";

  Future<dynamic> getResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl + url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body) as Map<String, dynamic>;
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}