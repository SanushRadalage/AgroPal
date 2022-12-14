import 'dart:io';

import 'package:agropal/models/feed_item.dart';
import 'package:agropal/models/login_model.dart';
import 'package:agropal/models/signup_model.dart';
import 'package:agropal/models/user.dart' as customUser;
import 'package:agropal/repository/post_repository.dart';
import 'package:agropal/widgets/snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthRepository {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final _postRepository = PostRepository();

  Stream<User?> get authStateChange => _auth.authStateChanges();

  String? _verificationId;
  int? _forceResendingToken;

  //  SignOut the current user
  Future<void> signOut(BuildContext context) async {
    await _auth
        .signOut()
        .whenComplete(() => Navigator.of(context).popAndPushNamed('/login'));
  }

  String getUserId() {
    return _auth.currentUser!.uid;
  }

  Future<void> signInWithPhone(
      BuildContext context,
      LoginModel loginModel,
      void Function() onSuccess,
      void Function() onError,
      void Function() onCodeSent) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: '${loginModel.countryCode}${loginModel.phoneNumber}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          _signIn(context, credential, onSuccess, onError);
        },
        verificationFailed: (FirebaseAuthException e) {
          _onError(context, e, onError);
        },
        codeSent: (verificationId, forceResendingToken) {
          _codeSent(verificationId, forceResendingToken);
          onCodeSent();
        },
        codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
        forceResendingToken: _forceResendingToken);
  }

  void uploadAvatar(BuildContext context, File file) async {
    try {
      await _storage
          .ref('users')
          .child(_auth.currentUser!.uid)
          .child('avatar.jpeg')
          .putFile(file)
          .then((p0) async {
        await _auth.currentUser?.updatePhotoURL(await p0.ref.getDownloadURL());
      });
    } on FirebaseException catch (e) {
      snackBar(e.message!);
      return null;
    }
  }

  _codeAutoRetrievalTimeout(String verificationId) {
    _codeSent(verificationId, null);
  }

  _codeSent(String verificationId, int? forceResendingToken) {
    _verificationId = verificationId;
    _forceResendingToken = forceResendingToken;
  }

  verifyOtp(BuildContext context, String otp, void Function() onSuccess,
      void Function() onError) async {
    if (_verificationId != null) {
      final credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: otp);
      await _signIn(context, credential, onSuccess, onError);
    }
  }

  _signIn(BuildContext context, AuthCredential credential,
      void Function() onSuccess, void Function()? onError) async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.linkWithCredential(credential).then((user) {
        onSuccess();
      }, onError: (e) => _onError(context, e, onError));
    } else {
      _auth.signInWithCredential(credential).then((user) {
        onSuccess();
      }, onError: (e) => _onError(context, e, onError));
    }
  }

  Future<void> updateUser(BuildContext context, SignupModel signupModel) async {
    await _auth.currentUser
        ?.updateDisplayName("${signupModel.firstName} ${signupModel.lastName}")
        .then((value) {
      final user = <String, dynamic>{
        "nic": signupModel.nic,
        "type": signupModel.type
      };

      _db
          .collection("users")
          .doc(_auth.currentUser?.uid)
          .set(user)
          .whenComplete(() {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      }).onError((error, stackTrace) {
        snackBar(AppLocalizations.of(context)!.commonErrorMsg);
      });
    });
  }

  Stream<customUser.User> getUserDetails() {
    final snapShots = _db.collection("users").doc(_auth.currentUser?.uid).get();
    return snapShots
        .asStream()
        .map((event) => customUser.User.fromDocument(event));
  }

  deleteAccount(BuildContext context) async {
    _db
        .collection('posts')
        .where('userId', isEqualTo: _auth.currentUser!.uid)
        .orderBy("createdAt", descending: true)
        .limit(250)
        .snapshots()
        .map((event) {
      event.docs.map((doc) {
        final item = FeedItem.fromMap(doc.id, doc.data());
        _postRepository.deletePost(item.id);
      });
    });

    _db.collection("users").doc(_auth.currentUser?.uid).delete().then((value) {
      signOut(context);
    });
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
