import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      child: const Text("Sign Out"),
      onPressed: () {
        FirebaseAuth.instance.signOut().whenComplete(
            () => Navigator.of(context).popAndPushNamed("/login"));
      },
    ));
  }
}
