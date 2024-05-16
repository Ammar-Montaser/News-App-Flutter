import 'dart:io';

import 'package:articles_app/core/failure/exception.dart';
import 'package:articles_app/core/failure/failure.dart';
import 'package:articles_app/features/blog/data/data_sources/blog_remote_db.dart';
import 'package:articles_app/features/blog/data/models/blog_model.dart';
import 'package:articles_app/features/blog/domain/entities/blog.dart';
import 'package:articles_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDB blogRemoteDB;

  BlogRepositoryImpl({required this.blogRemoteDB});
  @override
  Future<Either<Failure, Blog>> uploadBlog(
      {required File image,
      required String name,
      required String content,
      required String userId,
      required List<String> topics}) async {
    try {
      BlogModel blogModel = BlogModel(
          id: const Uuid().v1(),
          user_id: userId,
          title: name,
          content: content,
          image_url: "",
          topics: topics,
          updatedAt: DateTime.now());

      final url =
          await blogRemoteDB.uploadBlogImage(file: image, blog: blogModel);
      blogModel = blogModel.copyWith(image_url: url);
      final uploadedBlog = await blogRemoteDB.uploadBlog(blogModel);
      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      final blogs = await blogRemoteDB.getAllBlogs();
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
