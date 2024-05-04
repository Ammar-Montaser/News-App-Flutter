import 'package:articles_app/core/failure/failure.dart';
import 'package:articles_app/core/usecase/usecases.dart';
import 'package:articles_app/core/common/entities/user.dart';
import 'package:articles_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements Usecase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.SignUpWithEmail(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams(
      {required this.name, required this.email, required this.password});
}
