import 'package:cloud_firestore/cloud_firestore.dart';

class FeedItem {
  FeedItem(
      {required this.id,
      required this.district,
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
  String id;
  String district;
  String address;
  String landSize;
  String measureUnit;
  bool withFund;
  bool withEquipment;
  bool isOrganic;
  String leagalFund;
  String cropType;
  List images = [];
  String userId;
  String userName;
  String? avatar;
  Timestamp createdAt;
  Timestamp updatedAt;

  factory FeedItem.fromMap(String id, Map<String, dynamic> map) {
    return FeedItem(
        id: id,
        district: map['district'],
        address: map['address'],
        landSize: map['landSize'],
        measureUnit: map['measureUnit'],
        withFund: map['withFund'],
        withEquipment: map['withEquipment'],
        isOrganic: map['isOrganic'],
        leagalFund: map['leagalFund'],
        cropType: map['cropType'],
        images: map['images'],
        userId: map['userId'],
        userName: map['userName'],
        avatar: map['avatar'],
        createdAt: map['createdAt'],
        updatedAt: map['updatedAt']);
  }
}
