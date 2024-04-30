import 'package:articles_app/core/theme/theme.dart';
import 'package:articles_app/features/login/pages/LoginScreen.dart';
import 'package:articles_app/features/signup/pages/SignUpScreen.dart';
import 'package:flutter/material.dart';

void main() {
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
