import 'package:flutter/material.dart';

class Utils {
  static void goToNext(context, String route) {
    Navigator.pushReplacementNamed(context, route);
  }

  static void hideLoading(context) {
    Navigator.pop(context);
  }

  static void showLoading(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            CircularProgressIndicator(),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }

  static void showMessage(
      {required String message, required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
      ),
    );
  }
}
