import 'package:artisans/presentation/add_post/add_post_binding.dart';
import 'package:artisans/presentation/add_post/add_post_screen.dart';
import 'package:artisans/presentation/change_password/change_password_binding.dart';
import 'package:artisans/presentation/change_password/change_password_screen.dart';
import 'package:artisans/presentation/create_salon/create_salon_binding.dart';
import 'package:artisans/presentation/create_salon/create_salon_screen.dart';
import 'package:artisans/presentation/menu/menu_binding.dart';
import 'package:artisans/presentation/menu/menu_screen.dart';
import 'package:artisans/presentation/personal_data/personal_data_binding.dart';
import 'package:artisans/presentation/personal_data/personal_data_screen.dart';
import 'package:artisans/presentation/salon/salon_binding.dart';
import 'package:artisans/presentation/salon/salon_screen.dart';
import 'package:artisans/presentation/salons_map/salons_map_binding.dart';
import 'package:artisans/presentation/salons_map/salons_map_screen.dart';
import 'package:artisans/presentation/search/search_binding.dart';
import 'package:artisans/presentation/search/search_screen.dart';
import 'package:artisans/presentation/sign_in/sign_in_bindings.dart';
import 'package:artisans/presentation/sign_in/sign_in_screen.dart';
import 'package:artisans/presentation/sign_up/sign_up_binding.dart';
import 'package:artisans/presentation/sign_up/sign_up_screen.dart';
import 'package:artisans/presentation/single_chat/single_chat_binding.dart';
import 'package:artisans/presentation/splash/splash_bindings.dart';
import 'package:artisans/presentation/splash/splash_screen.dart';
import 'package:artisans/presentation/stories/stories_binding.dart';
import 'package:artisans/presentation/stories/stories_screen.dart';
import 'package:artisans/presentation/update_salon/update_salon_binding.dart';
import 'package:artisans/presentation/update_salon/update_salon_screen.dart';
import 'package:get/get.dart';
import '../../presentation/single_chat/single_chat_screen.dart';

class AppRoutes {
  static const String initialRoute = '/initial';
  static const String signInRoute = '/sign_in';
  static const String signUpRoute = "/sign_up";
  static const String menuRoute = "/menu";
  static const String searchRoute = "/search";
  static const String storiesRoute = "/stories";
  static const String salonRoute = "/salon";
  static const String addPostRoute = "/add_post";
  static const String createSalonRoute = "/create_salon";
  static const String personalDataRoute = "/personal_data";
  static const String changePasswordRoute = "/change_password";
  static const String splashRoute = "/splash";
  static const String updateSalonRoute = "/update_salon";
  static const String salonsMapRoute = "/salons_map_route";
  // static const String singleChatRoute = "/single_chat";

  static List<GetPage> pages = [
    GetPage(
        name: splashRoute,
        page: () => SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: signInRoute,
        page: () => const SignInScreen(),
        binding: SignInBindings()),
    GetPage(
        name: signUpRoute,
        page: () => const SignUpScreen(),
        binding: SignUpBinding()),
    GetPage(
        name: menuRoute,
        page: () => const MenuScreen(),
        binding: MenuBinding()),
    GetPage(
        name: searchRoute,
        page: () => const SearchScreen(),
        binding: SearchBinding()),
    GetPage(
        name: storiesRoute,
        page: () => const StoriesScreen(),
        binding: StoriesBinding()),
    GetPage(
        name: salonRoute,
        page: () => const SalonScreen(),
        binding: SalonBinding()),
    GetPage(
        name: addPostRoute,
        page: () => const AddPostScreen(),
        binding: AddPostBinding()),
    GetPage(
        name: createSalonRoute,
        page: () => const CreateSalonScreen(),
        binding: CreateSalonBinding()),
    GetPage(
        name: personalDataRoute,
        page: () => const PersonalDataScreen(),
        binding: PersonalDataBinding()),
    GetPage(
        name: changePasswordRoute,
        page: () => const ChangePasswordScreen(),
        binding: ChangePasswordBinding()),
    GetPage(
        name: updateSalonRoute,
        page: () => const UpdateSalonScreen(),
        binding: UpdateSalonBinding()),
    GetPage(
        name: salonsMapRoute,
        page: () => const SalonsMapScreen(),
        binding: SalonsMapBinding()),
    // GetPage(name: singleChatRoute, page: () => SingleChatScreen(), binding: SingleChatBinding())
  ];
}
