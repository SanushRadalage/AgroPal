import 'package:agropal/models/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpNotifier extends ChangeNotifier {
  final _model = SignupModel();
  SignupModel get signupModel => _model;

  updateModel(
      {String? firstName, String? lastName, String? nic, String? type}) {
    if (firstName != null) _model.firstName = firstName;
    if (lastName != null) _model.lastName = lastName;
    if (nic != null) _model.nic = nic;
    if (type != null) _model.type = type;
    notifyListeners();
  }
}

final signupModelProvider = ChangeNotifierProvider<SignUpNotifier>((ref) {
  return SignUpNotifier();
});
