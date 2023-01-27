import 'package:chating/database/database_utils.dart';
import 'package:chating/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  MyUser? user;
  User? fireAuthUser;
  UserProvider() {
    fireAuthUser = FirebaseAuth.instance.currentUser;
    initUser();
  }
  initUser() async {
    if (fireAuthUser != null) {
      user = await DatabaseUtils.getUser(fireAuthUser!.uid);
    }
  }
}
