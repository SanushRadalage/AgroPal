import 'package:shared_preferences/shared_preferences.dart';

/// This repository is to handle local settings of the application,
/// Netowork connectivity
/// Shared preferences

class SettingsRepository {
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  void setLocalePref(String locale) {
    _sharedPreferences.then((value) => {value.setString('locale', locale)});
  }

  Future<String?> getLocalePpef() {
    return _sharedPreferences.then((value) => value.getString('locale'));
  }
}
