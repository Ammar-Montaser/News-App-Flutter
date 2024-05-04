import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  final TextEditingController fieldController;
  final String hintText;
  final bool isExpand;
  const BlogEditor(
      {super.key,
      required this.fieldController,
      required this.hintText,
      required this.isExpand});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      maxLines: isExpand ? null : 1,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
