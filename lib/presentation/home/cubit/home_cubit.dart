import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
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

    _determinePosition();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    state.theme = prefs.getInt('theme') ?? 0;
    emit(state.copy(state));
  }

  Future<void> _determinePosition() async {
    state.locationStatus = 'checking_permission';
    emit(state.copy(state));

    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      state.locationStatus = 'disabled';
      emit(state.copy(state));
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        state.locationStatus = 'permission_denied';
        emit(state.copy(state));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      state.locationStatus = 'permission_denied_forever';
      emit(state.copy(state));
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    state.locationStatus = 'permission_granted';
    emit(state.copy(state));
  }

  Future<void> getLocationDetails() async {
    final LocationSettings locationSettings = WebSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
      maximumAge: Duration(minutes: 5),
    );
    Position position =
        await Geolocator.getCurrentPosition(locationSettings: locationSettings);
    state.currentPosition = position;
    state.locationStatus = 'success';
    emit(state.copy(state));
  }

  Future<void> getWeatherForecast({String cityName = 'Chandigarh'}) async {
    state.locationStatus = null;
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

  (String?, Color) locationStatusLabel() {
    if (state.locationStatus == 'permission_granted') {
      return (
        'We have received location permission. We are fetching location details.',
        Colors.black
      );
    } else if (state.locationStatus == 'checking_permission') {
      return ('We are checking for location permission.', Colors.black);
    } else if (state.locationStatus == 'disabled') {
      return ('Location services are disabled.', Colors.red);
    } else if (state.locationStatus == 'permission_denied') {
      return ('Location permissions are denied.', Colors.red);
    } else if (state.locationStatus == 'permission_denied_forever') {
      return (
        'Location permissions are permanently denied, we cannot request permissions.',
        Colors.red
      );
    } else if (state.locationStatus == 'fetching_location') {
      return ('We are fetching your location', Colors.yellow);
    } else {
      return (null, Colors.green);
    }
  }
}
