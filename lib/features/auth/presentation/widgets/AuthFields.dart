import 'package:flutter/material.dart';

class AuthFields extends StatelessWidget {
  String hintText;
  final TextEditingController controller;
  bool? isObscureText;
  bool? isPassword;

  VoidCallback? func;
  AuthFields({
    super.key,
    required this.hintText,
    required this.controller,
    required this.isPassword,
    this.isObscureText,
    this.func,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: Theme.of(context).textTheme.bodyMedium,
        controller: controller,
        obscureText: isObscureText ?? false,
        validator: (value) {
          if (value!.isEmpty) {
            return "$hintText is a required field!";
          }
          return null;
        },
        decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: isPassword == true
                ? IconButton(
                    onPressed: func,
                    icon: Icon(Icons.remove_red_eye),
                  )
                : null));
  }
}
