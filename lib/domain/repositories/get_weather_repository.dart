import 'package:weather_app/data/model/weather_response.dart';

abstract class GetWeatherRepository {
  Future<WeatherResponse> getWeatherForecast(String cityName);
}
