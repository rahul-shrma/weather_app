import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/model/weather_response.dart';
import 'package:weather_app/domain/usecases/get_weather_usecase.dart';
import 'package:weather_app/helper/debouncer.dart';
import 'package:weather_app/presentation/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.getWeatherUsecase) : super(HomeState());

  final GetWeatherUsecase getWeatherUsecase;

  final deBouncer = Debouncer(milliseconds: 300);

  Color getBackgroundColor() {
    if (state.theme == 0) {
      return Colors.white;
    }
    return Colors.black;
  }

  void init() async {
    state.cityNameController = TextEditingController();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    state.theme = prefs.getInt('theme') ?? 0;
    emit(state.copy(state));
  }

  Future<void> getWeatherForecast({String cityName = 'Chandigarh'}) async {
    state.loadingWeatherData = true;
    emit(state.copy(state));

    if (cityName == '') {
      cityName = 'Chandigarh';
    }
    WeatherResponse response =
        await getWeatherUsecase.getWeatherForecast(cityName);
    if (response.error != null) {
      state.weatherResponseError = response.error;
    } else {
      state.weatherResponse = response;
      state.weatherResponseError = null;
    }
    state.loadingWeatherData = false;
    emit(state.copy(state));
  }

  Future<void> saveTheme(int index) async {
    state.theme = index;
    emit(state.copy(state));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme', index);
  }

  Color getHintTextColor() {
    if (state.theme == 0) {
      return Colors.grey;
    }
    return Colors.white.withOpacity(0.5);
  }

  Color getTextColor() {
    if (state.theme == 0) {
      return Colors.black;
    }
    return Colors.white;
  }

  Color getBorderColor() {
    if (state.theme == 0) {
      return Colors.grey;
    }
    return Colors.white.withOpacity(0.5);
  }
}
