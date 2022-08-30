import 'package:intl/intl.dart';

class Validator {
  static bool validateSpecialChars(String? input) {
    if (input != null && input.length > 3) {
      return !RegExp(r"[`~!@#\$%^&*()-_=+[{]}\|;:'" ",<.>/?]").hasMatch(input);
    }
    return false;
  }

  static bool validateDateExpiry(String? input) {
    if (input != null && input.length == 8) {
      final duration =
          DateFormat('dd/MM/yy').parse(input).difference(DateTime.now());
      return duration.inDays >= 1;
    }
    return false;
  }
}
