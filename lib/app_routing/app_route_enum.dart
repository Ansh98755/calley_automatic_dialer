part of 'app_routing.dart';

enum AppRouteEnum {
  splashScreen(AppRouteName.splashScreen, "/${AppRouteName.splashScreen}"),
  languageSelect(AppRouteName.languageSelect, "/${AppRouteName.languageSelect}"),
  loginScreen(AppRouteName.loginScreen, "/${AppRouteName.loginScreen}"),
  verifyOtpScreen(AppRouteName.verifyOtpScreen, "/${AppRouteName.verifyOtpScreen}"),
  homeScreen(AppRouteName.homeScreen, "/${AppRouteName.homeScreen}"),
  callingDetailsScreen(AppRouteName.callingDetailsScreen, "/${AppRouteName.callingDetailsScreen}"),
  testListScreen(AppRouteName.testListScreen, "/${AppRouteName.testListScreen}");
  final String name;
  final String path;

  const AppRouteEnum(this.name, this.path);
}
