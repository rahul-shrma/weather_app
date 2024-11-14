import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/data/network/api_client.dart';
import 'package:weather_app/data/network/network_info.dart';
import 'package:weather_app/data/repositories/get_weather_repository_impl.dart';
import 'package:weather_app/domain/repositories/get_weather_repository.dart';
import 'package:weather_app/domain/usecases/get_weather_usecase.dart';
import 'package:weather_app/presentation/home/cubit/home_cubit.dart';
import 'package:weather_app/presentation/splash/cubit/app_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerLazySingleton<GlobalKey<ScaffoldMessengerState>>(
        () => GlobalKey<ScaffoldMessengerState>())

    //Network
    ..registerLazySingleton<ApiClient>(() => ApiClient(sl<Dio>()))
    ..registerLazySingleton<GetWeatherRepository>(
        () => GetWeatherRepositoryImpl(sl<ApiClient>()))

    //Usecases
    ..registerLazySingleton<GetWeatherUsecase>(
      () => GetWeatherUsecase(sl<GetWeatherRepository>()),
    )

    // Cubit
    ..registerFactory<HomeCubit>(() => HomeCubit(sl<GetWeatherUsecase>()))
    ..registerFactory<AppCubit>(() => AppCubit())

    // Core
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl())

    //! External
    ..registerLazySingleton<Dio>(() {
      final dio = Dio();
      return dio;
    });
}
