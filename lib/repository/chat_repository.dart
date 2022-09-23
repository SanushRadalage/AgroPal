import 'package:agropal/models/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatRepository {
  static final _db = FirebaseDatabase.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addNewMessage(ChatModel chatModel) async {
    final senderMap = <String, dynamic>{
      "senderId": _auth.currentUser?.uid,
      "receiverId": chatModel.recieverId,
      "message": chatModel.message,
      "avatar": chatModel.avatar ?? "",
      "createdAt": chatModel.createdAt
    };

    final receiverMap = <String, dynamic>{
      "receiverId": _auth.currentUser?.uid,
      "senderId": chatModel.recieverId,
      "message": chatModel.message,
      "avatar": chatModel.avatar ?? "",
      "createdAt": chatModel.createdAt
    };

    DatabaseReference ref = _db.ref("chats");
    await ref
        .child(_auth.currentUser!.uid)
        .child(chatModel.recieverId)
        .push()
        .set(senderMap)
        .whenComplete(() => {
              ref
                  .child(chatModel.recieverId)
                  .child(_auth.currentUser!.uid)
                  .push()
                  .set(receiverMap)
            });
  }
}
