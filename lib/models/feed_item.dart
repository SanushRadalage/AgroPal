import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedItem {
  FeedItem(
      {required this.district,
      required this.address,
      required this.landSize,
      required this.measureUnit,
      required this.withFund,
      required this.withEquipment,
      required this.isOrganic,
      required this.leagalFund,
      required this.cropType,
      required this.images,
      required this.userId,
      required this.userName,
      required this.avatar,
      required this.createdAt,
      required this.updatedAt});
  String district;
  String address;
  String landSize;
  String measureUnit;
  bool withFund;
  bool withEquipment;
  bool isOrganic;
  String leagalFund;
  String cropType;
  List images;
  String userId;
  String userName;
  String? avatar;
  Timestamp createdAt;
  Timestamp updatedAt;
}
