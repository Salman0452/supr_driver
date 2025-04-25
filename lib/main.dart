import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supr_driver/app/app.dart';
// import 'package:supr_driver/app/app_translations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Configure system UI overlay style for both light and dark modes
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // Dark mode settings for system navigation bar
    systemNavigationBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  await Hive.initFlutter();
  // Hive.registerAdapter(UserAdapter());

  await Hive.openBox<dynamic>('authBox');
  await Hive.openBox<dynamic>('app_config');

  // await AppTranslation.init();

  runApp(const App());
}
