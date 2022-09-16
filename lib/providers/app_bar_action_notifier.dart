import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActionStateProvider extends ChangeNotifier {
  bool _isVisible = true;
  bool get isVisible => _isVisible;

  update({required isVisible}) {
    _isVisible = isVisible;
    notifyListeners();
  }
}

final actionStateProvider =
    ChangeNotifierProvider((ref) => ActionStateProvider());
