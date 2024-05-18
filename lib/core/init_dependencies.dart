import 'package:articles_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:articles_app/core/network/connection_checker.dart';
import 'package:articles_app/core/secrets/app_secrets.dart';
import 'package:articles_app/features/auth/data/datas_sources/auth_remote_db.dart';
import 'package:articles_app/features/auth/data/repository/auth_repository_Impl.dart';
import 'package:articles_app/features/auth/domain/repository/auth_repository.dart';
import 'package:articles_app/features/auth/domain/usecases/current_User.dart';
import 'package:articles_app/features/auth/domain/usecases/user_login.dart';
import 'package:articles_app/features/auth/domain/usecases/user_logout.dart';
import 'package:articles_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:articles_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:articles_app/features/blog/data/data_sources/blog_local_db.dart';
import 'package:articles_app/features/blog/data/data_sources/blog_remote_db.dart';
import 'package:articles_app/features/blog/data/repositories/blog_repositories_impl.dart';
import 'package:articles_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:articles_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:articles_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:articles_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
      url: AppSecrets.url, anonKey: AppSecrets.anonKey);
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(() => Hive.box(name: "blogs"));
  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(internetConnection: serviceLocator()));
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDB>(() => AuthRemoteDBImpl(
          serviceLocator(),
        ))
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(
        authRemoteDB: serviceLocator(), connectionChecker: serviceLocator()))
    ..registerFactory(() => UserSignUp(authRepository: serviceLocator()))
    ..registerFactory(() => UserLogin(authRepository: serviceLocator()))
    ..registerFactory(() => CurrentUser(authRepository: serviceLocator()))
    ..registerFactory(() => UserLogout(authRepository: serviceLocator()))
    ..registerLazySingleton(() => AppUserCubit())
    ..registerLazySingleton(() => AuthBloc(
          userSignUp: serviceLocator(),
          userLogin: serviceLocator(),
          currentUser: serviceLocator(),
          appUserCubit: serviceLocator(),
          userLogout: serviceLocator(),
        ));
}

void _initBlog() {
  serviceLocator
    ..registerFactory<BlogRemoteDB>(
        () => BlogRemoteDBImpl(supabaseClient: serviceLocator()))
    ..registerFactory<BlogLocalDB>(() => BlogLocalDBImpl(box: serviceLocator()))
    ..registerFactory<BlogRepository>(() => BlogRepositoryImpl(
        blogRemoteDB: serviceLocator(),
        blogLocalDB: serviceLocator(),
        connectionChecker: serviceLocator()))
    ..registerFactory(() => UploadBlog(blogRepository: serviceLocator()))
    ..registerFactory(() => getAllBlogs(blogRepository: serviceLocator()))
    ..registerLazySingleton(() => BlogBloc(
        uploadBlog: serviceLocator(), get_all_blogs: serviceLocator()));
}
