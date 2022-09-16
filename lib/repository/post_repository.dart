import 'dart:io';

import 'package:agropal/models/feed_item.dart';
import 'package:agropal/models/post_model.dart';
import 'package:agropal/widgets/snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class PostRepository {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  var uuid = const Uuid().v4();

  _generateNewId() {
    uuid = const Uuid().v4();
  }

  Future<void> createPost(BuildContext context, PostModel postModel) async {
    final post = <String, dynamic>{
      "district": postModel.district,
      "address": postModel.address,
      "landSize": postModel.size,
      "measureUnit": postModel.mesureUnit,
      "withFund": postModel.fundStatus,
      "withEquipment": postModel.equipmentStatus,
      "isOrganic": postModel.organicStatus,
      "leagalFund": postModel.leagalFundStatus,
      "cropType": postModel.cropType,
      "images": postModel.images.isNotEmpty ? postModel.images : [],
      "userId": _auth.currentUser?.uid,
      "userName": _auth.currentUser?.displayName,
      "avatar": _auth.currentUser?.photoURL,
      "createdAt": Timestamp.now(),
      "updatedAt": Timestamp.now()
    };

    _db.collection("posts").doc(uuid).set(post).whenComplete(() {
      _generateNewId();
      snackBar(AppLocalizations.of(context)!.createPostSuccess);
      Navigator.of(context).popAndPushNamed('/home');
    }).onError((error, stackTrace) {
      _generateNewId();
      snackBar(AppLocalizations.of(context)!.commonErrorMsg);
    });
  }

  Future<String?> uploadFile(BuildContext context, File file) async {
    try {
      final task = await _storage
          .ref('posts')
          .child(uuid)
          .child('${const Uuid().v4()}.jpeg')
          .putFile(file)
          .whenComplete(() => null);

      return task.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      snackBar(e.message!);
      return null;
    }
  }

  Future uploadFiles(BuildContext context, List<File> images) async {
    List<String> urls = [];
    await Future.wait(images.map((image) => uploadFile(context, image)))
        .then((value) => print(value));
  }

  Future<List<FeedItem>> fetchPosts(FeedItem? feedItem) async {
    final ref = _db.collection('posts');

    final documentSnapshot = feedItem == null
        ? await ref.orderBy('createdAt', descending: true).limit(250).get()
        : await ref
            .orderBy("createdAt", descending: true)
            .startAfter([feedItem.createdAt])
            .limit(250)
            .get();

    return documentSnapshot.docs
        .map<FeedItem>((data) => FeedItem(
            district: data['district'],
            address: data['address'],
            landSize: data['landSize'],
            measureUnit: data['measureUnit'],
            withFund: data['withFund'],
            withEquipment: data['withEquipment'],
            isOrganic: data['isOrganic'],
            leagalFund: data['leagalFund'],
            cropType: data['cropType'],
            images: data['images'],
            userId: data['userId'],
            userName: data['userName'],
            avatar: data['avatar'],
            createdAt: data['createdAt'],
            updatedAt: data['updatedAt']))
        .toList();
  }

  _onError(
      BuildContext context, FirebaseAuthException e, void Function()? onError) {
    final snackBar = SnackBar(
      content: Text(e.message!),
      backgroundColor: Theme.of(context).errorColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    if (onError != null) onError();
  }
}
