import 'dart:convert';

import 'package:agropal/models/chat_model.dart';
import 'package:agropal/theme/colors.dart';
import 'package:agropal/widgets/chat_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final List<ChatModel> _chatList = [];

  @override
  void initState() {
    super.initState();
    chatList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _chatList.length,
      itemBuilder: (context, index) {
        return ChatItemView(chatModel: _chatList[index]);
      },
      separatorBuilder: ((context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Divider(
            color: AppColors.borderColor,
            thickness: 1,
          ),
        );
      }),
    );
  }

  chatList() async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.data() != null) {
        value.data()!.forEach((key, value) {
          final decodeModel = jsonDecode(value) as Map<String, dynamic>;
          final chatModel = ChatModel.fromMap(decodeModel);
          setState(() {
            _chatList.add(chatModel);
          });
        });
      }
    });
  }
}
