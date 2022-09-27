import 'dart:convert';

import 'package:agropal/models/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatRepository {
  static final _db = FirebaseDatabase.instance;
  static final _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addNewMessage(ChatModel chatModel) async {
    final messageMap = <String, dynamic>{
      "senderId": _auth.currentUser?.uid,
      "receiverId": chatModel.recieverId,
      "message": chatModel.message,
      "avatar": chatModel.avatar ?? "",
      "createdAt": chatModel.createdAt,
      "recieverName": chatModel.recieverName
    };

    DatabaseReference ref = _db.ref("chats");
    await ref
        .child(_auth.currentUser!.uid)
        .child(chatModel.recieverId)
        .push()
        .set(messageMap)
        .whenComplete(() => {
              ref
                  .child(chatModel.recieverId)
                  .child(_auth.currentUser!.uid)
                  .push()
                  .set(messageMap)
                  .whenComplete(() {
                final senderSnapShot =
                    _firestore.collection("chats").doc(_auth.currentUser!.uid);
                final recieverSnapShot =
                    _firestore.collection("chats").doc(chatModel.recieverId);

                final jsonChatModel = chatModel.toJson();
                String jsontringMap = json.encode(jsonChatModel);
                final senderMap = <String, String>{
                  chatModel.recieverId: jsontringMap
                };
                final receiverMap = <String, String>{
                  _auth.currentUser!.uid: jsontringMap
                };
                senderSnapShot.set(senderMap, SetOptions(merge: true));
                recieverSnapShot.set(receiverMap, SetOptions(merge: true));
              })
            });
  }
}
