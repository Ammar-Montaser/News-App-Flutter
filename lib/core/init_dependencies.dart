import 'package:articles_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:articles_app/core/secrets/app_secrets.dart';
import 'package:articles_app/features/auth/data/datas_sources/auth_remote_db.dart';
import 'package:articles_app/features/auth/data/repository/auth_repository_Impl.dart';
import 'package:articles_app/features/auth/domain/repository/auth_repository.dart';
import 'package:articles_app/features/auth/domain/usecases/current_User.dart';
import 'package:articles_app/features/auth/domain/usecases/user_login.dart';
import 'package:articles_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:articles_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
      url: AppSecrets.url, anonKey: AppSecrets.anonKey);
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDB>(() => AuthRemoteDBImpl(
          serviceLocator(),
        ))
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(authRemoteDB: serviceLocator()))
    ..registerFactory(() => UserSignUp(authRepository: serviceLocator()))
    ..registerFactory(() => UserLogin(authRepository: serviceLocator()))
    ..registerFactory(() => CurrentUser(authRepository: serviceLocator()))
    ..registerLazySingleton(() => AppUserCubit())
    ..registerLazySingleton(() => AuthBloc(
          userSignUp: serviceLocator(),
          userLogin: serviceLocator(),
          currentUser: serviceLocator(),
          appUserCubit: serviceLocator(),
        ));
}
