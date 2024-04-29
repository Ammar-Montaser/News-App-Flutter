import 'package:flutter/material.dart';

class AuthFields extends StatelessWidget {
  String hintText;
  final TextEditingController controller;
  bool isObscureText;

  AuthFields({
    super.key,
    required this.hintText,
    required this.controller,
    required this.isObscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: Theme.of(context).textTheme.bodyMedium,
        controller: controller,
        obscureText: isObscureText,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: isObscureText
              ? IconButton(
                  onPressed: () {
                    isObscureText = !isObscureText;
                  },
                  icon: Icon(Icons.remove_red_eye),
                )
              : null,
        ));
  }
}
