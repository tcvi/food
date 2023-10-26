import 'package:camera/camera.dart';
import 'package:config_env/feature/food_app/detail/detail_screen.dart';
import 'package:config_env/feature/login/login_screen.dart';
import 'package:config_env/feature/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../food_app/business/business_screen.dart';
import '../food_app/home/home_screen.dart';
import '../food_app/home_app/home_app_screen.dart';
import '../food_app/school/school_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return HomeAppScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const HomeScreen(),
              key: state.pageKey,
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                  child: child,
                );
              },
            );
          },
        ),
        GoRoute(
          path: '/business',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const BusinessScreen(),
              key: state.pageKey,
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                  child: child,
                );
              },
            );
          },
        ),
        GoRoute(
          path: '/school',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const SchoolScreen(),
              key: state.pageKey,
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                  child: child,
                );
              },
            );
          },
        ),
      ],
    ),
    GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/detail',
        builder: (_, state) => const DetailScreen(),
        routes: [
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: 'take_picture',
            name: 'AAAAA',
            builder: (_, state) {
              CameraDescription camera = state.extra as CameraDescription;
              return SizedBox();
              // return TakePictureScreen(camera: camera);
            },
          ),
        ]),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);
