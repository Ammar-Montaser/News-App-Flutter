import 'package:flutter/material.dart';

class BlogViewer extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogViewer());
  const BlogViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [],
      ),
    );
  }
}
