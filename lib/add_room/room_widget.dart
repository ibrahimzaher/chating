import 'package:chating/chat/chat_view.dart';
import 'package:chating/model/category.dart';
import 'package:chating/model/room.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget {
  const RoomWidget({Key? key, required this.room}) : super(key: key);
  final Room room;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ChatView.routeName, arguments: room);
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/${room.categoryId}${room.categoryId == Category.movies ? '.png' : '.jpg'}',
              width: 100,
              height: 100,
            ),
            Text(room.roomTitle),
          ],
        ),
      ),
    );
  }
}
