import 'package:chating/chat/chat_navigator.dart';
import 'package:chating/database/database_utils.dart';
import 'package:chating/model/message.dart';
import 'package:chating/model/my_user.dart';
import 'package:chating/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatViewModel extends ChangeNotifier {
  late ChatNavigator navigator;
  late MyUser currentUser;
  late Room room;
  sendMessage(String content) async {
    Message message = Message(
      roomId: room.roomId,
      content: content,
      dateTime: DateTime.now().millisecondsSinceEpoch,
      senderId: currentUser.id,
      senderName: currentUser.userName,
    );
    try {
      var result = await DatabaseUtils.insertMessage(message);
      navigator.clearMessage();
    } catch (e) {
      navigator.showMessage(e.toString());
    }
  }

  late Stream<QuerySnapshot<Message>> messages;
  void getMessages() {
    messages = DatabaseUtils.getMessages(room.roomId);
  }
}
