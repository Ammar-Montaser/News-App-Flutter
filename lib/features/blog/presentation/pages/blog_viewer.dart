import 'package:articles_app/core/utils/calc_reading_time.dart';
import 'package:articles_app/core/utils/format_date.dart';
import 'package:articles_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlogViewer extends StatelessWidget {
  final Blog blog;
  static route(Blog blog) => MaterialPageRoute(
      builder: (context) => BlogViewer(
            blog: blog,
          ));
  const BlogViewer({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          blog.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    blog.image_url,
                    width: double.infinity,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "By ${blog.userName} | ${calcReadingTime(blog.content)} min",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Spacer(),
                    Text(
                      "${formatDateBydMMMYYYY(blog.updatedAt)}",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(),
                SizedBox(
                  height: 5,
                ),
                Text(
                  blog.content,
                  style: TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 18, height: 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
