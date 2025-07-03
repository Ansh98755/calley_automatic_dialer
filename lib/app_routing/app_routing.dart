import 'package:calley_automatic_dialer/views/calling_details_screen/calling_details_screen.dart';
import 'package:calley_automatic_dialer/views/calling_details_screen/test_list_screen.dart';
import 'package:calley_automatic_dialer/views/language_select_screen.dart';
import 'package:calley_automatic_dialer/views/login_screen/login_screen.dart';
import 'package:calley_automatic_dialer/views/verify_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../views/home_screen/home_screen.dart';
import '../views/splash_screen/splash_screen.dart';

part 'app_route_enum.dart';

part 'app_route_names.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final String initRouteLocation = AppRouteEnum.splashScreen.path;

abstract final class AppRouting {
  static final appRouter = GoRouter(navigatorKey: rootNavigatorKey, initialLocation: initRouteLocation, routes: [
    GoRoute(
      path: AppRouteEnum.splashScreen.path,
      name: AppRouteEnum.splashScreen.name,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRouteEnum.languageSelect.path,
      name: AppRouteEnum.languageSelect.name,
      builder: (context, state) => LanguageSelectScreen(),
    ),
    GoRoute(
      path: AppRouteEnum.loginScreen.path,
      name: AppRouteEnum.loginScreen.name,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      name: AppRouteEnum.verifyOtpScreen.name,
      path: AppRouteEnum.verifyOtpScreen.path,
      builder: (context, state) => VerifyOtpScreen(),
    ),
    GoRoute(
      name: AppRouteEnum.homeScreen.name,
      path: AppRouteEnum.homeScreen.path,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      name: AppRouteEnum.callingDetailsScreen.name,
      path: AppRouteEnum.callingDetailsScreen.path,
      builder: (context, state) => CallingDetailsScreen(),
    ),
    GoRoute(
      name: AppRouteEnum.testListScreen.name,
      path: AppRouteEnum.testListScreen.path,
      builder: (context, state) => TestListScreen(),
    ),
  ]);

  static BuildContext get rootNavigatorKeyContext => rootNavigatorKey.currentContext!;
}
