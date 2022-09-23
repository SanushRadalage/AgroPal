class ChatModel {
  ChatModel(
      {required this.recieverId,
      required this.senderId,
      required this.message,
      required this.avatar,
      required this.createdAt});
  String recieverId;
  String senderId;
  String message;
  String? avatar;
  int createdAt;

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
        avatar: map['avatar'] ?? '',
        senderId: map['senderId'] ?? '',
        message: map['message'] ?? '',
        recieverId: map['receiverId'] ?? '',
        createdAt: map['createdAt'] ?? 0);
  }
}
