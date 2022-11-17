import 'package:flutter/material.dart';
import 'package:gia_su_trung_tam_mobile/UI/splash/splash_screen.dart';

class ManagerRoutes {
  ManagerRoutes._();
  static String loginScreen = '/loginScreen';
  static String splashScreen = '/splasScreen';
  // MANAGERS
  static Map<String, Widget Function(BuildContext context)> manager = {
    //loginScreen: (context) => const StudentLoginScreen(),
    splashScreen: (context) => const SplashScreen(),
  };
}
