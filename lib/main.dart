import 'package:articles_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:articles_app/core/init_dependencies.dart';
import 'package:articles_app/core/theme/theme.dart';
import 'package:articles_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:articles_app/features/auth/presentation/pages/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
      BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    BlocProvider.of<AuthBloc>(context).add(isUserLoggedIn());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      darkTheme: getDarkThemeData(),
      theme: getLightThemeData(),
      themeMode: ThemeMode.system,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return Scaffold(
              body: Text("Home"),
            );
          }
          return LoginScreen();
        },
      ),
    );
  }
}
