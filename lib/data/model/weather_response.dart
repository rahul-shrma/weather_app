import 'package:weather_app/data/model/current.dart';
import 'package:weather_app/data/model/forecasr.dart';
import 'package:weather_app/data/model/location.dart';
import 'package:weather_app/data/model/weather_response_error.dart';
import 'package:weather_app/helper/helper.dart';

class WeatherResponse {
  Location? location;
  Current? current;
  WeatherResponseError? error;
  Forecast? forecast;

  WeatherResponse({
    required this.location,
    required this.current,
    required this.forecast,
    required this.error,
  });

  WeatherResponse.error({
    this.error,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic>? json) =>
      WeatherResponse(
        location: Location.fromJson(asMap(json, 'location')),
        current: Current.fromJson(asMap(json, 'current')),
        forecast: Forecast.fromJson(asMap(json, 'forecast')),
        error: null,
      );

  Map<String, dynamic> toJson() => {
        'location': location?.toJson(),
        'current': current?.toJson(),
      };
}
