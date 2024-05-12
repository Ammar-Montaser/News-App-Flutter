import 'dart:io';

import 'package:articles_app/core/failure/failure.dart';
import 'package:articles_app/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String name,
    required String content,
    required String userId,
    required List<String> topics,
  });
}
