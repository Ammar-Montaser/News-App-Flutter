import 'package:articles_app/core/failure/exception.dart';
import 'package:articles_app/core/failure/failure.dart';
import 'package:articles_app/core/network/connection_checker.dart';
import 'package:articles_app/features/auth/data/datas_sources/auth_remote_db.dart';
import 'package:articles_app/core/common/entities/user.dart';
import 'package:articles_app/features/auth/data/models/userModel.dart';
import 'package:articles_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDB authRemoteDB;
  final ConnectionChecker connectionChecker;
  const AuthRepositoryImpl({
    required this.authRemoteDB,
    required this.connectionChecker,
  });

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
      if (await connectionChecker.isConnected) {
        final user = await fn();
        return right(user);
      } else {
        return left(Failure("No internet connection!"));
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await connectionChecker.isConnected) {
        final session = authRemoteDB.currentUserSession;
        if (session == null) {
          return left(Failure("User not logged in"));
        }
        return right(UserModel(
            id: session.user.id, name: "", email: session.user.email ?? ""));
      }

      final res = await authRemoteDB.getCurrentUserData();
      if (res != null) {
        return right(res);
      } else {
        return left(Failure("User not logged in"));
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      return right(authRemoteDB.logout());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
