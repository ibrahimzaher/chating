import 'dart:async';

import 'package:chating/database/database_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_navigator.dart';

class LoginViewModel extends ChangeNotifier {
  late LoginNavigator navigator;
  void loginWithEmailAndPassword(
      {required String email, required String password}) async {
    navigator.showLoading();
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      var user = await DatabaseUtils.getUser(credential.user!.uid);
      navigator.hideLoading();
      navigator.showMessage(message: 'Login Successfully');
      Timer(const Duration(milliseconds: 2), () {
        navigator.hideLoading();
        navigator.goToNext(user!);
      });
    } on FirebaseAuthException catch (e) {
      navigator.hideLoading();
      if (e.code == 'user-not-found') {
        navigator.showMessage(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        navigator.showMessage(
            message: 'Wrong password provided for that user.');
      } else {
        print('dasdas');
        navigator.showMessage(message: 'Not Have Internet');
      }
    }
  }
}
