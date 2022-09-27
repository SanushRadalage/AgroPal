import 'package:agropal/repository/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postRepositoryProvider =
    Provider<PostRepository>((ref) => PostRepository());

class SortOptionsNotifier extends ChangeNotifier {
  String _district = "All";
  String _cropType = "";
  int _fundStatus = 0;
  String get district => _district;
  String get cropType => _cropType;
  int get fundStatus => _fundStatus;

  updateDistrict({String? district}) {
    _district = district ?? "";
    notifyListeners();
  }

  updateCropType({String? cropType}) {
    _cropType = cropType ?? "";
    notifyListeners();
  }

  updateFundStatus({int? fundStatus}) {
    _fundStatus = fundStatus ?? 0;
    notifyListeners();
  }
}

final sortOptionProvider = ChangeNotifierProvider<SortOptionsNotifier>((ref) {
  return SortOptionsNotifier();
});
