import 'package:artisans/presentation/menu/menu_binding.dart';
import 'package:artisans/presentation/menu/menu_screen.dart';
import 'package:artisans/presentation/sign_in/sign_in_bindings.dart';
import 'package:artisans/presentation/sign_in/sign_in_screen.dart';
import 'package:artisans/presentation/sign_up/sign_up_binding.dart';
import 'package:artisans/presentation/sign_up/sign_up_screen.dart';
import 'package:artisans/presentation/splash/splash_bindings.dart';
import 'package:artisans/presentation/splash/splash_screen.dart';
import 'package:get/get.dart';
class AppRoutes {
  static const String initialRoute = '/initial';
  static const String signInRoute = '/sign_in';
  static const String signUpRoute = "/sign_up";
  static const String menuRoute = "/menu";

  static List<GetPage> pages = [
    GetPage(name: initialRoute, page: () => SplashScreen(), binding: SplashBindings()),
    GetPage(name: signInRoute, page: () => const SignInScreen(), binding: SignInBindings()),
    GetPage(name: signUpRoute, page: () => const SignUpScreen(), binding: SignUpBinding()),
    GetPage(name: menuRoute, page: () => const MenuScreen(), binding: MenuBinding()),
  ];
}