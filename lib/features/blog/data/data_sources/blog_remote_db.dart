import 'dart:io';

import 'package:articles_app/core/failure/exception.dart';
import 'package:articles_app/features/blog/data/models/blog_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDB {
  Future<String> uploadBlogImage({required File file, required BlogModel blog});

  Future<BlogModel> uploadBlog(BlogModel blog);
}

class BlogRemoteDBImpl implements BlogRemoteDB {
  final SupabaseClient supabaseClient;

  BlogRemoteDBImpl({required this.supabaseClient});
  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData =
          await supabaseClient.from("blogs").insert(blog.toMap()).select();
      return BlogModel.fromMap(blogData.first);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File file,
    required BlogModel blog,
  }) async {
    try {
      await supabaseClient.storage.from("blog_images").upload(blog.id, file);
      return supabaseClient.storage.from("blog_images").getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
