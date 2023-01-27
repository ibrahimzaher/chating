import 'package:flutter/material.dart';

class CustomButtonIcon extends StatelessWidget {
  CustomButtonIcon(
      {Key? key,
      required this.background,
      required this.foreground,
      required this.onPress,
      required this.text})
      : super(key: key);
  final Color background;
  final Color foreground;
  void Function()? onPress;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 18,
        ),
        backgroundColor: background,
      ),
      onPressed: onPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            text,
            style: TextStyle(
              color: foreground,
            ),
          ),
          Icon(
            Icons.arrow_forward,
            color: foreground,
          ),
        ],
      ),
    );
  }
}
