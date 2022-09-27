import 'package:agropal/models/chat_model.dart';
import 'package:agropal/models/user.dart' as customUser;
import 'package:agropal/theme/colors.dart';
import 'package:agropal/utils/date_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatItemView extends StatelessWidget {
  const ChatItemView({Key? key, required this.chatModel}) : super(key: key);

  final ChatModel chatModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (chatModel.recieverId == FirebaseAuth.instance.currentUser!.uid) {
          Navigator.of(context).pushNamed('/chat',
              arguments: customUser.User(
                  id: chatModel.senderId,
                  avatar: chatModel.avatar,
                  name: chatModel.recieverName));
        } else {
          Navigator.of(context).pushNamed('/chat',
              arguments: customUser.User(
                  id: chatModel.recieverId,
                  avatar: chatModel.avatar,
                  name: chatModel.recieverName));
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 12, right: 8, left: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: chatModel.avatar != null
                        ? NetworkImage(chatModel.avatar!)
                        : const NetworkImage(
                            "https://firebasestorage.googleapis.com/v0/b/agropal-532e9.appspot.com/o/user.png?alt=media&token=3711fab4-1f20-4c33-a562-a382c94acdec"),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          chatModel.recieverName,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          chatModel.message,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.iconColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              formatMilllis(chatModel.createdAt),
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
