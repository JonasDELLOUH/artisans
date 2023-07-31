import 'package:artisans/core/languages/languages.dart';
import 'package:artisans/core/routes/app_routes.dart';
import 'package:artisans/core/themes/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/themes/themes.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppRoutes.pages,
      initialRoute: AppRoutes.menuRoute,
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      locale: Get.deviceLocale,
      themeMode: ThemeService().getThemeMode(),
      theme: Themes().lightTheme,
      darkTheme: Themes().lightTheme,
    );
  }
}