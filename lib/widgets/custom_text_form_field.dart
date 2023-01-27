import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {Key? key,
      required this.hintText,
      required this.validate,
      required this.controller,
      this.maxLength,
      this.minLength})
      : super(key: key);
  final String hintText;
  final Function validate;
  final TextEditingController controller;
  int? minLength;
  int? maxLength;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      maxLines: maxLength ?? 1,
      minLines: minLength ?? 1,
      validator: (text) => validate(text),
      controller: controller,
    );
  }
}
