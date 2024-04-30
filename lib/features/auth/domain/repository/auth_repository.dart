import 'package:articles_app/core/failure/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> SignUpWithEmail({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> SignInWithEmail({
    required String email,
    required String password,
  });
}
