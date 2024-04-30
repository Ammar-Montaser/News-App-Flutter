import 'package:articles_app/core/secrets/app_secrets.dart';
import 'package:articles_app/core/theme/theme.dart';
import 'package:articles_app/features/auth/presentation/pages/LoginScreen.dart';
import 'package:articles_app/features/auth/presentation/pages/SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
      url: AppSecrets.url, anonKey: AppSecrets.anonKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      darkTheme: getDarkThemeData(),
      theme: getLightThemeData(),
      themeMode: ThemeMode.system,
      home: LoginScreen(),
    );
  }
}
