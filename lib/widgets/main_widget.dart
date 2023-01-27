import 'package:flutter/material.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({Key? key, required this.widget}) : super(key: key);
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Image.asset(
          'assets/images/bg_main.png',
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        widget,
      ],
    );
  }
}
