import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToggleButtonNotifier with ChangeNotifier {
  final List<bool> _sizeToggleClickState = <bool>[true, false];
  final List<bool> _investToggleClickState = <bool>[true, false];
  final List<bool> _machineryToggleClickState = <bool>[true, false];
  final List<bool> _organicToggleClickState = <bool>[true, false];
  final List<bool> _lawyerFeeToggleClickState = <bool>[true, false, false];

  List<bool> get sizeToggleClickState => _sizeToggleClickState;
  List<bool> get investToggleClickState => _investToggleClickState;
  List<bool> get machineryToggleClickState => _machineryToggleClickState;
  List<bool> get organicToggleClickState => _organicToggleClickState;
  List<bool> get lawyerFeeToggleClickState => _lawyerFeeToggleClickState;

  updateSizeToggle(int index) {
    for (int i = 0; i < _sizeToggleClickState.length; i++) {
      _sizeToggleClickState[i] = i == index;
    }
    notifyListeners();
  }

  updateInvestToggle(int index) {
    for (int i = 0; i < _investToggleClickState.length; i++) {
      _investToggleClickState[i] = i == index;
    }
    notifyListeners();
  }

  updateMachineryToggle(int index) {
    for (int i = 0; i < _machineryToggleClickState.length; i++) {
      _machineryToggleClickState[i] = i == index;
    }
    notifyListeners();
  }

  updateOrganicToggle(int index) {
    for (int i = 0; i < _organicToggleClickState.length; i++) {
      _organicToggleClickState[i] = i == index;
    }
    notifyListeners();
  }

  updateLawyerFeeToggle(int index) {
    for (int i = 0; i < _lawyerFeeToggleClickState.length; i++) {
      _lawyerFeeToggleClickState[i] = i == index;
    }
    notifyListeners();
  }

  resetButtons() {
    _sizeToggleClickState.clear();
    _sizeToggleClickState.add(true);
    _sizeToggleClickState.add(false);

    _investToggleClickState.clear();
    _investToggleClickState.add(true);
    _investToggleClickState.add(false);

    _machineryToggleClickState.clear();
    _machineryToggleClickState.add(true);
    _machineryToggleClickState.add(false);

    _organicToggleClickState.clear();
    _organicToggleClickState.add(true);
    _organicToggleClickState.add(false);

    _lawyerFeeToggleClickState.clear();
    _lawyerFeeToggleClickState.add(true);
    _lawyerFeeToggleClickState.add(false);
    _lawyerFeeToggleClickState.add(false);
  }
}

final toggleButtonProvider =
    ChangeNotifierProvider((ref) => ToggleButtonNotifier());
