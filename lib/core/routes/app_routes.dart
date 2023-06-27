import 'package:artisans/presentation/sign_in/sign_in_bindings.dart';
import 'package:artisans/presentation/sign_in/sign_in_screen.dart';
import 'package:artisans/presentation/splash/splash_bindings.dart';
import 'package:artisans/presentation/splash/splash_screen.dart';
import 'package:get/get.dart';
class AppRoutes {
  static const String initialRoute = '/initial_route';
  static const String signInRoute = '/sign_in_route';

  static List<GetPage> pages = [
    GetPage(name: initialRoute, page: () => SplashScreen(), binding: SplashBindings()),
    GetPage(name: signInRoute, page: () => SignInScreen(), binding: SignInBindings())
  ];
}