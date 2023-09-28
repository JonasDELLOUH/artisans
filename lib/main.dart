import 'package:artisans/core/languages/languages.dart';
import 'package:artisans/core/routes/app_routes.dart';
import 'package:artisans/core/services/app_services.dart';
import 'package:artisans/core/themes/theme_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/functions/app_functions.dart';
import 'core/themes/themes.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppRoutes.pages,
      // initialRoute: AppRoutes.createSalonRoute,
      initialRoute: isNotLogin() ? AppRoutes.signInRoute : AppRoutes.menuRoute,
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      locale: Get.deviceLocale,
      themeMode: ThemeService().getThemeMode(),
      theme: Themes().lightTheme,
      darkTheme: Themes().lightTheme,
      initialBinding: AppServicesBinding(),
    );
  }
}
