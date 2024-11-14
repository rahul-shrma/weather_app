import 'package:weather_app/data/model/weather_response.dart';
import 'package:weather_app/domain/repositories/get_weather_repository.dart';

class GetWeatherUsecase {
  GetWeatherUsecase(this.getWeatherRepository);

  final GetWeatherRepository getWeatherRepository;

  Future<WeatherResponse> getWeatherForecast(String cityName) async {
    return getWeatherRepository.getWeatherForecast(cityName);
  }
}
