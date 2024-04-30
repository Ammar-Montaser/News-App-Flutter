import 'package:articles_app/core/failure/failure.dart';
import 'package:articles_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Failure, String>> SignInWithEmail(
      {required String email, required String password}) {
    // TODO: implement SignInWithEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> SignUpWithEmail(
      {required String name, required String email, required String password}) {
    // TODO: implement SignUpWithEmail
    throw UnimplementedError();
  }
}
