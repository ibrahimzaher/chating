class Message {
  static const String collectionName = 'message';
  String id;
  String roomId;
  String content;
  String senderId;
  String senderName;
  int dateTime;
  Message(
      {this.id = '',
      required this.roomId,
      required this.content,
      required this.dateTime,
      required this.senderId,
      required this.senderName});
  Message.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          roomId: json['roomId'],
          dateTime: json['dateTime'],
          content: json['content'],
          senderId: json['senderId'],
          senderName: json['senderName'],
        );
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomId': roomId,
      'dateTime': dateTime,
      'content': content,
      'senderId': senderId,
      'senderName': senderName,
    };
  }
}
