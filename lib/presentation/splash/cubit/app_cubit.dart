import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/presentation/splash/cubit/app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState());

  void init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    state.theme = prefs.getInt('theme') ?? 0;
    emit(state.copy(state));
  }

  Future<void> startTimer({int seconds = 3}) async {
    Future.delayed(Duration(seconds: seconds), () {
      state.moveToHome = true;
      emit(state.copy(state));
    });
  }

  Color getBackgroundColor() {
    if (state.theme == 0) {
      return Colors.white;
    }
    return Colors.black;
  }

  Color getTextColor() {
    if (state.theme == 0) {
      return Colors.black;
    }
    return Colors.white;
  }
}
