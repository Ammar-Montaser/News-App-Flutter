import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddBlog extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => AddBlog());
  const AddBlog({super.key});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Blog"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.done_rounded),
          ),
        ],
      ),
    );
  }
}
