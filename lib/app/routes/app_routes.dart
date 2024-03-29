import 'package:flutter/material.dart';
import 'package:real_estate_app/features/auth/screens/register_screen.dart';
import 'package:real_estate_app/features/home/screens/home_screen_body.dart';
import 'package:real_estate_app/features/onboarding/splash_screen.dart';
import 'package:real_estate_app/features/auth/screens/login_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    SplashScreen.splashScreen: (context) => const SplashScreen(),
    LoginScreen.loginScreen: (context) => const LoginScreen(),
    RegisterScreen.registerScreen: (context) => RegisterScreen(),
    HomeScreen.homeScreen: (context) => const HomeScreen(),
  };
}
