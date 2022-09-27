import 'package:agropal/models/post_model.dart';
import 'package:agropal/repository/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreatePostNotifier extends ChangeNotifier {
  var _model = PostModel();
  PostModel get postModel => _model;

  final _postRepository = PostRepository();
  PostRepository get postRepository => _postRepository;

  updateModel(
      {String? district,
      String? address,
      String? size,
      int? mesureUnit,
      bool? equipmentStatus,
      bool? fundStatus,
      String? leagalFundAmount,
      bool? organicStatus,
      String? cropType,
      List<String>? images}) {
    if (district != null) _model.district = district;
    if (address != null) _model.address = address;
    if (size != null) _model.size = size;
    if (mesureUnit != null) {
      if (mesureUnit == 0) {
        postModel.mesureUnit = "acre";
      } else {
        postModel.mesureUnit = "perch";
      }
    }
    if (equipmentStatus != null) _model.equipmentStatus = equipmentStatus;
    if (fundStatus != null) _model.fundStatus = fundStatus;
    if (leagalFundAmount != null) _model.leagalFundStatus = leagalFundAmount;
    if (organicStatus != null) _model.organicStatus = organicStatus;
    if (cropType != null) _model.cropType = cropType;
    if (images != null && images.isNotEmpty) _model.images = images;
    notifyListeners();
  }

  resetModel() {
    final postModel = PostModel();
    _model = postModel;
    notifyListeners();
  }
}

final createPostModelProvider =
    ChangeNotifierProvider<CreatePostNotifier>((ref) {
  return CreatePostNotifier();
});
