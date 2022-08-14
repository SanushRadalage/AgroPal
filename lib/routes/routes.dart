import 'package:agropal/views/auth/login.dart';
import 'package:agropal/views/auth/otp.dart';
import 'package:agropal/views/home/home.dart';
import 'package:agropal/views/onBoard/locale_selection.dart';
import 'package:agropal/views/onBoard/splash.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (context) => const Home());
      case '/localeSelection':
        return MaterialPageRoute(builder: (context) => const LocaleSelection());
      case '/login':
        return MaterialPageRoute(builder: (context) => const Login());
      case '/otp':
        return MaterialPageRoute(builder: (context) => const OtpVerifier());
      case '/':
      default:
        return MaterialPageRoute(builder: (context) => const Splash());
    }
  }
}
