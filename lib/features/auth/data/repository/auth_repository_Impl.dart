import 'package:articles_app/core/failure/exception.dart';
import 'package:articles_app/core/failure/failure.dart';
import 'package:articles_app/features/auth/data/datas_sources/auth_remote_db.dart';
import 'package:articles_app/features/auth/domain/entities/user.dart';
import 'package:articles_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDB authRemoteDB;

  const AuthRepositoryImpl({required this.authRemoteDB});

  @override
  Future<Either<Failure, User>> SignInWithEmail(
      {required String email, required String password}) async {
    return _getUser(() async =>
        await authRemoteDB.SignInWithEmail(email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> SignUpWithEmail(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(() async => await authRemoteDB.SignUpWithEmail(
        name: name, email: email, password: password));
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
