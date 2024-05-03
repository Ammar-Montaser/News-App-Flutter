import 'package:articles_app/core/failure/failure.dart';
import 'package:articles_app/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> SignUpWithEmail({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> SignInWithEmail({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> currentUser();
}
