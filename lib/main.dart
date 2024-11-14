import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/usecases/get_weather_usecase.dart';
import 'package:weather_app/helper/system_settings.dart';
import 'package:weather_app/presentation/home/cubit/home_cubit.dart';
import 'package:weather_app/presentation/splash/cubit/app_cubit.dart';
import 'package:weather_app/router/app_router.dart';
import 'package:weather_app/injection/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    di.init(),
    SystemSettings.lockRotation(),
    SystemSettings.makeTransparentAppBar(),
  ]);
  runApp(
    WeatherApp(),
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (BuildContext context) => AppCubit(),
        ),
        BlocProvider<HomeCubit>(
          create: (BuildContext context) =>
              HomeCubit(di.sl<GetWeatherUsecase>()),
        ),
      ],
      child: MaterialApp.router(
        title: "Weather App",
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        themeMode: ThemeMode.light,
        scaffoldMessengerKey: di.sl<GlobalKey<ScaffoldMessengerState>>(),
      ),
    );
  }
}
