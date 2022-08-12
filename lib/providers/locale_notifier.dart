import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocaleNotifier extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}

final localeProvider = StateProvider((ref) => LocaleNotifier());
