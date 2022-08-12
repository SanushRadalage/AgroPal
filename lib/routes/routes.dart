import 'package:agropal/views/auth/login.dart';
import 'package:agropal/views/onBoard/locale_selection.dart';
import 'package:agropal/views/onBoard/splash.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/localeSelection':
        return MaterialPageRoute(builder: (context) => LocaleSelection());
      case '/login':
        return MaterialPageRoute(builder: (context) => Login());
      case '/':
      default:
        return MaterialPageRoute(builder: (context) => const Splash());
    }
  }
}
