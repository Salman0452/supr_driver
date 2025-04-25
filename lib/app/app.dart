import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supr_driver/Utils/app_config.dart';
import 'package:supr_driver/app/app_theme.dart';
import 'package:supr_driver/app/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConfig.appName,
        textDirection: TextDirection.ltr,
        // translationsKeys: AppTranslation.translationsKeys,
        locale: Get.locale,
        initialRoute: Routes.splashScreen,
        getPages: Routes.routes,
        
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        
        // Theme mode listener to update system UI overlay style when theme changes
        builder: (context, child) {
          // Get the current brightness
          final brightness = MediaQuery.of(context).platformBrightness;
          final isDarkMode = brightness == Brightness.dark;
          
          // Set system UI overlay style based on current theme
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            systemNavigationBarColor: isDarkMode ? Colors.black : Colors.white,
            systemNavigationBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
          ));
          
          return child!;
        },
      ),
    );
  }
}
