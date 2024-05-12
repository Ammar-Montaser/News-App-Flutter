import 'dart:io';

import 'package:articles_app/core/failure/failure.dart';
import 'package:articles_app/core/usecase/usecases.dart';
import 'package:articles_app/features/blog/domain/entities/blog.dart';
import 'package:articles_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements Usecase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlog({required this.blogRepository});

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
        image: params.image,
        name: params.title,
        content: params.content,
        userId: params.userid,
        topics: params.topics);
  }
}

class UploadBlogParams {
  final String userid;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogParams(
      {required this.userid,
      required this.title,
      required this.content,
      required this.image,
      required this.topics});
}
