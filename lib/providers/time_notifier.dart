import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeNotifier extends ChangeNotifier {
  void delayOnNavigate(BuildContext context, int sec, String destination) {
    Timer(Duration(seconds: sec), () {
      Navigator.of(context).popAndPushNamed(destination);
    });
  }
}

final timerProvider = ChangeNotifierProvider((ref) => TimeNotifier());
