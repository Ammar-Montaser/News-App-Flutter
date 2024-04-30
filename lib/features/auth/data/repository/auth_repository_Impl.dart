import 'package:articles_app/core/failure/exception.dart';
import 'package:articles_app/core/failure/failure.dart';
import 'package:articles_app/features/auth/data/datas_sources/auth_remote_db.dart';
import 'package:articles_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDB authRemoteDB;

  const AuthRepositoryImpl({required this.authRemoteDB});

  @override
  Future<Either<Failure, String>> SignInWithEmail(
      {required String email, required String password}) {
    // TODO: implement SignInWithEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> SignUpWithEmail(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final userID = await authRemoteDB.SignUpWithEmail(
          name: name, email: email, password: password);
      return right(userID);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
