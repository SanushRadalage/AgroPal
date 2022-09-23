import 'dart:convert';

import 'package:agropal/models/chat_model.dart';
import 'package:agropal/providers/chat_provider.dart';
import 'package:agropal/theme/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatView extends StatefulWidget {
  ChatView({Key? key, required this.userId}) : super(key: key);

  String userId;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  List<types.Message> _messages = [];

  @override
  void initState() {
    super.initState();
    getMessageList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        elevation: 1,
        leading: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_left,
              size: 38,
            )),
        title: Row(
          children: [
            CircleAvatar(
              radius: 13,
              backgroundImage: const AssetImage('assets/images/user.png'),
              child: Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/agropal-532e9.appspot.com/o/user.png?alt=media&token=921a61b8-8fb7-4cdc-a910-afde7c40bfad"),
            ),
            const SizedBox(
              width: 6,
            ),
            const Flexible(
              child: Text(
                "Sanush Radalage",
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
        actions: null,
      ),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return Chat(
            theme: DefaultChatTheme(
              primaryColor: AppColors.secondary,
              secondaryColor: AppColors.primary,
              inputBorderRadius: const BorderRadius.all(Radius.circular(16)),
              inputTextDecoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.primary, width: 1.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.borderColor, width: 1.0),
                  )),
              inputBackgroundColor: AppColors.background,
              inputTextColor: Colors.black,
            ),
            isAttachmentUploading: false,
            messages: _messages,
            onMessageTap: (context, p1) {},
            onPreviewDataFetched: (p0, p1) {},
            onSendPressed: (p0) {
              ref.watch(chatProvider).addNewMessage(ChatModel(
                  recieverId: widget.userId,
                  senderId: FirebaseAuth.instance.currentUser!.uid,
                  message: p0.text,
                  avatar: null,
                  createdAt: Timestamp.now().millisecondsSinceEpoch));
            },
            showUserAvatars: true,
            showUserNames: false,
            user: types.User(
                id: FirebaseAuth.instance.currentUser!.uid,
                imageUrl: FirebaseAuth.instance.currentUser!.photoURL ??
                    'https://firebasestorage.googleapis.com/v0/b/agropal-532e9.appspot.com/o/user.png?alt=media&token=3711fab4-1f20-4c33-a562-a382c94acdec'),
          );
        },
      ),
    );
  }

  getMessageList() {
    FirebaseDatabase.instance
        .ref('chats')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child(widget.userId)
        .onChildAdded
        .listen((event) {
      setState(() {
        if (mounted) {
          Map<String, dynamic> map = {};
          for (var element in event.snapshot.children) {
            map.addEntries([MapEntry(element.key!, element.value)]);
          }
          final chatModel = ChatModel.fromMap(map);
          final textMessage = types.TextMessage(
            author:
                types.User(id: chatModel.senderId, imageUrl: chatModel.avatar),
            createdAt: DateTime.now().millisecondsSinceEpoch,
            id: event.snapshot.key!,
            text: chatModel.message,
          );
          _messages.insert(0, textMessage);
        }
      });
    });
  }
}
