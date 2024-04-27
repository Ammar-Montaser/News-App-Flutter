import 'package:articles_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

ThemeData getLightThemeData() {
  return ThemeData(
    scaffoldBackgroundColor: LightTheme.backgroundColor,
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: fontSize.largeBodyFontSize,
        color: LightTheme.primaryColor,
      ),
    ),
  );
}

ThemeData getDarkThemeData() {
  return ThemeData(
    scaffoldBackgroundColor: DarkTheme.backgroundColor,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: fontSize.largeBodyFontSize,
        color: DarkTheme.primaryColor,
      ),
    ),
  );
}
