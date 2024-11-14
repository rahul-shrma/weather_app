import 'package:weather_app/data/model/weather_response.dart';
import 'package:weather_app/data/network/api_client.dart';
import 'package:weather_app/domain/repositories/get_weather_repository.dart';

class GetWeatherRepositoryImpl implements GetWeatherRepository {
  GetWeatherRepositoryImpl(this.apiClient);

  final ApiClient apiClient;

  @override
  Future<WeatherResponse> getWeatherForecast(String cityName) async {
    return await apiClient.getWeatherForecast(cityName);
  }
}
