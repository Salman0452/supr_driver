import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supr_driver/screens/splash_screen.dart';
import 'package:supr_driver/screens/onboarding_screen.dart';
import 'package:supr_driver/screens/auth/register_screen.dart';
import 'package:supr_driver/screens/auth/login_screen.dart';

class Routes {
  static const splashScreen = '/splash';
  static const onboardingScreen = '/onboarding';
  static const registerScreen = '/register';
  static const loginScreen = '/login';


  static final routes = <GetPage<Widget>>[
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onboardingScreen, page: () => const OnboardingScreen()),
    GetPage(name: registerScreen, page: () => RegisterScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
  ];
}
extension RoutesExtension on String {
  void push() {
    Get.toNamed<void>(this);
  }

  void pushReplace() {
    Get.offNamed<void>(this);
  }
}