import 'package:articles_app/core/utils/calc_reading_time.dart';
import 'package:articles_app/features/blog/domain/entities/blog.dart';
import 'package:articles_app/features/blog/presentation/pages/blog_viewer.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, BlogViewer.route());
      },
      child: Container(
        margin: EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: blog.topics
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Chip(
                            label: Text(e),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Text(
              blog.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Spacer(),
            Text(
              "${calcReadingTime(blog.content)} min",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
