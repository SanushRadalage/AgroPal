import 'package:agropal/models/login_model.dart';
import 'package:agropal/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authenticationProvider =
    Provider<AuthRepository>((ref) => AuthRepository());

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authenticationProvider).authStateChange;
});

class VerifyPhoneProvider with ChangeNotifier {
  final authRepository = AuthRepository();
}

class LoginModelNotifier extends ChangeNotifier {
  final LoginModel _loginModel = LoginModel();
  String? _otp;

  LoginModel get loginModel => _loginModel;
  String? get otp => _otp;

  updateModel({String? countryCode, String? phoneNumber}) {
    if (countryCode != null) _loginModel.countryCode = countryCode;
    if (phoneNumber != null) _loginModel.phoneNumber = phoneNumber;
    notifyListeners();
  }

  updateOtp(String? otp) {
    if (otp != null) _otp = otp;
    notifyListeners();
  }
}

final loginModelProvider = ChangeNotifierProvider<LoginModelNotifier>((ref) {
  return LoginModelNotifier();
});
