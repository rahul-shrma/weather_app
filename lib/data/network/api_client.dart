import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/data/model/weather_response.dart';
import 'package:weather_app/data/model/weather_response_error.dart';

class ApiClient {
  ApiClient(this.dioClient);

  final Dio dioClient;

  String baseUrl() {
    const String _mode =
        String.fromEnvironment('WEATHER_APP_MODE', defaultValue: 'develop');
    switch (_mode) {
      case 'production':
        return 'http://api.weatherapi.com/v1';
      case 'staging':
        return 'http://api.weatherapi.com/v1';
      case 'develop':
        return 'http://api.weatherapi.com/v1';
      default:
        throw 'WEATHER_APP_MODE not found';
    }
  }

  Future<WeatherResponse> getWeatherForecast(String cityName) async {
    const weatherApiKey = String.fromEnvironment('WEATHER_KEY');
    String url = '${baseUrl()}/forecast.json';
    Map<String, dynamic> parameters = {
      "key": weatherApiKey,
      "q": cityName,
      "days": 5
    };
    try {
      debugPrint('GET $url');
      final response = await dioClient.get(url, queryParameters: parameters);
      debugPrint('Response ${response.data}');
      if (response.statusCode == 200) {
        return WeatherResponse.fromJson(response.data);
      } else {
        WeatherResponseError error = WeatherResponseError(
            'Failed to get forecast for searched location',
            response.statusCode);
        return WeatherResponse.error(error: error);
      }
    } on DioException catch (error) {
      if (error.response?.data != null) {
        final message = error.response?.data["error"]["message"] ??
            'Server has thrown 404 error';
        WeatherResponseError errorResponse =
            WeatherResponseError(message, error.response?.statusCode);
        return WeatherResponse.error(error: errorResponse);
      } else {
        final message = 'Server has thrown ${error.response?.statusCode} error';
        WeatherResponseError errorResponse =
            WeatherResponseError(message, error.response?.statusCode);
        return WeatherResponse.error(error: errorResponse);
      }
    } catch (error) {
      final message = error.toString();
      WeatherResponseError errorResponse = WeatherResponseError(message, -1);
      return WeatherResponse.error(error: errorResponse);
    }
  }
}
