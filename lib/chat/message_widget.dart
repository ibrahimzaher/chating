import 'package:chating/model/message.dart';
import 'package:chating/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({Key? key, required this.message}) : super(key: key);
  final Message message;
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user;
    return Column(
      crossAxisAlignment: user!.id == message.senderId
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: user.id == message.senderId
                ? Colors.grey.shade600
                : Colors.blue,
            borderRadius: BorderRadius.only(
              bottomRight:
                  Radius.circular(user.id != message.senderId ? 0 : 12),
              bottomLeft: Radius.circular(user.id != message.senderId ? 12 : 0),
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
            ),
          ),
          child: Text(
            message.content,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
          ),
          child: Text(
            "${DateTime.fromMillisecondsSinceEpoch(message.dateTime).day}/${DateTime.fromMillisecondsSinceEpoch(message.dateTime).month}/${DateTime.fromMillisecondsSinceEpoch(message.dateTime).year}",
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
