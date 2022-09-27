import 'package:shared_preferences/shared_preferences.dart';

/// This repository is to handle local settings of the application,
/// Netowork connectivity
/// Shared preferences

class SettingsRepository {
  static final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  void setLocalePref(String locale) {
    _sharedPreferences.then((value) => {value.setString('locale', locale)});
  }

  Future<String> getLocalePref() async {
    var value =
        await _sharedPreferences.then((value) => value.getString('locale'));
    if (value != null) {
      return value;
    } else {
      return 'en';
    }
  }
}
