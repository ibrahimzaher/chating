import 'package:chating/add_room/add_room_navigator.dart';
import 'package:chating/database/database_utils.dart';
import 'package:chating/model/room.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class AddRoomViewModel extends ChangeNotifier {
  late AddRoomNavigator navigator;
  void addRoom(
      {required String roomTitle,
      required String roomDescription,
      required String categoryId}) async {
    navigator.showLoading();
    Room room = Room(
        roomTitle: roomTitle,
        categoryId: categoryId,
        roomDescription: roomDescription,
        roomId: '');
    if (await InternetConnectionChecker().hasConnection) {
      try {
        await DatabaseUtils.addRoomToFireStore(room);
        navigator.hideLoading();
        navigator.showMessage('Added Room Successfully');
      } catch (e) {
        navigator.hideLoading();
        navigator.showMessage(e.toString());
      }
    } else {
      navigator.hideLoading();
      navigator.showMessage('Error Not Have Internet');
    }
  }
}
