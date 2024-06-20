
import 'package:flutter/material.dart';
import 'package:todo/constants/contants.dart';
import 'package:todo/helpers/colors.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final validator;
  final onChange;
  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      this.validator,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged:onChange ,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: kWhiteColor)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kWhiteColor),
            ),
            fillColor: kgreyColor,
            filled: true,
            hintText: hintText,
            hintStyle: hintStyle),
        validator: validator);
  }
}
