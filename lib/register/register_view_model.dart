import 'dart:async';

import 'package:chating/database/database_utils.dart';
import 'package:chating/model/my_user.dart';
import 'package:chating/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  late RegisterNavigator navigator;
  void createAccount(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String userName}) async {
    navigator.showLoading();
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var myUser = MyUser(
          email: email,
          userName: userName,
          lastName: lastName,
          id: data.user!.uid,
          firstName: firstName);
      await DatabaseUtils.userRegister(myUser);
      navigator.hideLoading();
      navigator.showMessage(message: 'Register Successfully');
      Timer(const Duration(milliseconds: 2), () {
        navigator.hideLoading();
        navigator.goToNext(myUser);
      });
    } on FirebaseAuthException catch (e) {
      navigator.hideLoading();
      if (e.code == 'weak-password') {
        navigator.showMessage(message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        navigator.showMessage(
            message: 'The account already exists for that email.');
      }
    } catch (e) {
      navigator.hideLoading();
      navigator.showMessage(message: 'Error Occur when Create Account');
    }
  }
}
