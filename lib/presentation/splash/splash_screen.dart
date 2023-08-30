import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:artisans/presentation/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splash: Text('dhdhd'), nextScreen: Get.put(SignInScreen()),
      ),
    );
  }
}
