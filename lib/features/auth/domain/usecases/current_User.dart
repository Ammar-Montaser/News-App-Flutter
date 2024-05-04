import 'package:articles_app/core/failure/failure.dart';
import 'package:articles_app/core/usecase/usecases.dart';
import 'package:articles_app/core/common/entities/user.dart';
import 'package:articles_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class CurrentUser implements Usecase<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUser({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
