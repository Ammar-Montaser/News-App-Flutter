import 'package:articles_app/core/failure/failure.dart';
import 'package:articles_app/core/usecase/usecases.dart';
import 'package:articles_app/features/blog/domain/entities/blog.dart';
import 'package:articles_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class getAllBlogs implements Usecase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;

  getAllBlogs({required this.blogRepository});
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
