import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supr_driver/screens/splash_screen.dart';
import 'package:supr_driver/screens/onboarding_screen.dart';
import 'package:supr_driver/screens/auth/register_screen.dart';
import 'package:supr_driver/screens/auth/password_register_screen.dart';
import 'package:supr_driver/screens/auth/login_screen.dart';
import 'package:supr_driver/screens/auth/forgot_password_screen.dart';
import 'package:supr_driver/screens/auth/reset_password_screen.dart';
import 'package:supr_driver/screens/auth/password_changed_screen.dart';

class Routes {
  static const splashScreen = '/splash';
  static const onboardingScreen = '/onboarding';
  static const registerScreen = '/register';
  static const passwordRegisterScreen = '/passwordRegister';
  static const loginScreen = '/login';
  static const forgotPasswordScreen = '/forgotPasswordScreen';
  static const resetPasswordScreen = '/resetPasswordScreen';
  static const passwordChangedScreen = '/passwordChangedScreen';


  static final routes = <GetPage<Widget>>[
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onboardingScreen, page: () => const OnboardingScreen()),
    GetPage(name: registerScreen, page: () => RegisterScreen()),
    GetPage(name: passwordRegisterScreen, page: () => const PasswordRegisterScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: forgotPasswordScreen, page: () => const ForgotPasswordScreen()),
    GetPage(name: resetPasswordScreen, page: () => const ResetPasswordScreen()),
    GetPage(name: passwordChangedScreen, page: () => const PasswordChangedScreen()),

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