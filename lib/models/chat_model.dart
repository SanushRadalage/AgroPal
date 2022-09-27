class ChatModel {
  ChatModel(
      {required this.recieverId,
      required this.senderId,
      required this.message,
      required this.avatar,
      required this.createdAt,
      required this.recieverName});
  String recieverId;
  String senderId;
  String message;
  String? avatar;
  int createdAt;
  String recieverName;

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
        avatar: map['avatar'] ??
            "https://firebasestorage.googleapis.com/v0/b/agropal-532e9.appspot.com/o/user.png?alt=media&token=921a61b8-8fb7-4cdc-a910-afde7c40bfad",
        senderId: map['senderId'] ?? '',
        message: map['message'] ?? '',
        recieverId: map['receiverId'] ?? '',
        createdAt: map['createdAt'] ?? 0,
        recieverName: map['recieverName'] ?? '');
  }

  Map<String, dynamic> toJson() => {
        'senderId': senderId,
        'receiverId': recieverId,
        'createdAt': createdAt,
        'message': message,
        'avatar': avatar,
        'recieverName': recieverName
      };
}
