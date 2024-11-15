import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/model/weather_response.dart';
import 'package:weather_app/data/model/weather_response_error.dart';

class HomeState {

  String? locationStatus;
  int theme = 0;
  bool loadingWeatherData = false;
  late TextEditingController cityNameController;
  WeatherResponse? weatherResponse;
  WeatherResponseError? weatherResponseError;
  Position? currentPosition;

  HomeState copy(HomeState state) {
    HomeState newState = HomeState();
    newState.theme = state.theme;
    newState.cityNameController = state.cityNameController;
    newState.weatherResponse = state.weatherResponse;
    newState.weatherResponseError = state.weatherResponseError;
    newState.loadingWeatherData = state.loadingWeatherData;
    newState.locationStatus = state.locationStatus;
    newState.currentPosition = state.currentPosition;
    return newState;
  }

}
