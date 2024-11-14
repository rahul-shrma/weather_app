import 'package:flutter/material.dart';
import 'package:weather_app/data/model/weather_response.dart';
import 'package:weather_app/data/model/weather_response_error.dart';

class HomeState {
  int theme = 0;
  bool loadingWeatherData = false;
  late TextEditingController cityNameController;
  WeatherResponse? weatherResponse;
  WeatherResponseError? weatherResponseError;

  HomeState copy(HomeState state) {
    HomeState newState = HomeState();
    newState.theme = state.theme;
    newState.cityNameController = state.cityNameController;
    newState.weatherResponse = state.weatherResponse;
    newState.weatherResponseError = state.weatherResponseError;
    newState.loadingWeatherData = state.loadingWeatherData;
    return newState;
  }
}
