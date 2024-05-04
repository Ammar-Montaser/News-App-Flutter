import 'package:articles_app/core/failure/failure.dart';
import 'package:articles_app/core/usecase/usecases.dart';
import 'package:articles_app/core/common/entities/user.dart';
import 'package:articles_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements Usecase<User, UserLoginParams> {
  final AuthRepository authRepository;

  UserLogin({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.SignInWithEmail(
        email: params.email, password: params.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}
