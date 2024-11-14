import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/presentation/home/home_screen.dart';
import 'package:weather_app/presentation/splash/splash_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return SplashScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          name: 'home',
          path: 'home',
          pageBuilder: (context, state) {
            return MaterialPage<void>(
              key: state.pageKey,
              child: HomeScreen(),
            );
          },
        ),
      ],
    ),

    // GoRoute(
    //   path: '/',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return SplashScreen();
    //   },
    //   routes: <RouteBase>[
    //     GoRoute(
    //       name: 'home',
    //       path: 'home',
    //       pageBuilder: (context, state) {
    //         return MaterialPage<void>(
    //           key: state.pageKey,
    //           child: HomeScreen(),
    //         );
    //       },
    //     ),
    //   ],
    // ),
  ],
);
