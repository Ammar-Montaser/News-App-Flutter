import 'package:articles_app/core/common/widgets/loader.dart';
import 'package:articles_app/core/init_dependencies.dart';
import 'package:articles_app/core/utils/snackbar.dart';
import 'package:articles_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:articles_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:articles_app/features/blog/presentation/pages/add_blog.dart';
import 'package:articles_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});
  static route() => MaterialPageRoute(builder: (context) => BlogPage());

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    BlocProvider.of<BlogBloc>(context).add(BlogGetAllBlogs());
    super.initState();
  }

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
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is Blogloading) {
            return Loader();
          }
          if (state is BlogDisplaySuccess) {
            return ListView.builder(
              itemCount: state.blogList.length,
              itemBuilder: (context, index) {
                final blog = state.blogList[index];
                return BlogCard(
                  blog: blog,
                  color: Colors.amberAccent,
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
