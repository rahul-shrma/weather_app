import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/presentation/splash/cubit/app_cubit.dart';
import 'package:weather_app/presentation/splash/cubit/app_state.dart';

import '../../injection/injection_container.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = sl<AppCubit>();
    cubit
      ..init()
      ..startTimer();
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          if (state.moveToHome) {
            context.go("/home");
          }
        },
        bloc: cubit,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: cubit.getBackgroundColor(),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/img/ic_weather.png',
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Weather App',
                    style: TextStyle(
                        color: cubit.getTextColor(),
                        fontSize: 24,
                        fontFamily: 'Bold'),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
