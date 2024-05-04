import 'package:articles_app/features/blog/presentation/pages/add_blog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog App"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, AddBlog.route());
              },
              icon: Icon(CupertinoIcons.add_circled))
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
