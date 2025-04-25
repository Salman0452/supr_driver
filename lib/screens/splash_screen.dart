import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supr_driver/app/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), _navigateToNext);
  }

  Future<void> _navigateToNext() async {
    Get.offNamed(Routes.onboardingScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
