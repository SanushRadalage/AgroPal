import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  late final String id;
  final String? avatar;
  late final String name;
  String? role;

  User({required this.id, required this.avatar, required this.name, this.role});

  factory User.fromDocument(DocumentSnapshot snapshot) {
    return User(
        avatar: FirebaseAuth.instance.currentUser!.photoURL ??
            "https://firebasestorage.googleapis.com/v0/b/agropal-532e9.appspot.com/o/user.png?alt=media&token=921a61b8-8fb7-4cdc-a910-afde7c40bfad",
        id: FirebaseAuth.instance.currentUser!.uid,
        name: FirebaseAuth.instance.currentUser!.displayName ?? '',
        role: snapshot['type'] ?? '');
  }
}
