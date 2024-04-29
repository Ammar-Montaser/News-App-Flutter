import 'package:articles_app/core/theme/app_pallete.dart';
import 'package:articles_app/core/theme/font_size.dart';
import 'package:flutter/material.dart';

ThemeData getLightThemeData() {
  return ThemeData(
    scaffoldBackgroundColor: LightTheme.backgroundColor,
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: fontSize.largeHeadingFontSize,
        fontWeight: FontWeight.bold,
        color: LightTheme.primaryColor,
      ),
      bodyLarge: TextStyle(
        fontSize: fontSize.largeBodyFontSize,
        color: LightTheme.primaryColor,
      ),
      bodyMedium: TextStyle(
        fontSize: fontSize.mediumBodyFontSize,
        color: LightTheme.primaryColor,
      ),
      bodySmall: TextStyle(
        fontSize: fontSize.smallBodyFontSize,
        color: LightTheme.primaryColor,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      labelStyle: TextStyle(
        fontSize: fontSize.smallBodyFontSize,
        fontWeight: FontWeight.normal,
        color: LightTheme.primaryColor,
      ),
      hintStyle: TextStyle(
        fontSize: fontSize.mediumBodyFontSize,
        fontWeight: FontWeight.normal,
        color: LightTheme.primaryColor,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: LightTheme.primaryColor, width: 3),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: LightTheme.brandingColor, width: 3),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)))),
        backgroundColor: MaterialStatePropertyAll(LightTheme.brandingColor),
        foregroundColor: MaterialStatePropertyAll(LightTheme.primaryColor),
        textStyle: MaterialStatePropertyAll(
          TextStyle(
              fontSize: fontSize.mediumBodyFontSize,
              fontWeight: FontWeight.bold),
        ),
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
      ),
    ),
  );
}

ThemeData getDarkThemeData() {
  return ThemeData(
    scaffoldBackgroundColor: DarkTheme.backgroundColor,
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: fontSize.largeHeadingFontSize,
        fontWeight: FontWeight.bold,
        color: DarkTheme.primaryColor,
      ),
      bodyLarge: TextStyle(
        fontSize: fontSize.largeBodyFontSize,
        color: DarkTheme.primaryColor,
      ),
      bodyMedium: TextStyle(
        fontSize: fontSize.mediumBodyFontSize,
        color: DarkTheme.primaryColor,
      ),
      bodySmall: TextStyle(
        fontSize: fontSize.smallBodyFontSize,
        color: DarkTheme.primaryColor,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      labelStyle: TextStyle(
        fontSize: fontSize.smallBodyFontSize,
        fontWeight: FontWeight.normal,
        color: DarkTheme.primaryColor,
      ),
      hintStyle: TextStyle(
        fontSize: fontSize.mediumBodyFontSize,
        fontWeight: FontWeight.normal,
        color: DarkTheme.primaryColor,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: DarkTheme.primaryColor, width: 3),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: DarkTheme.brandingColor, width: 3),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)))),
        backgroundColor: MaterialStatePropertyAll(DarkTheme.brandingColor),
        foregroundColor: MaterialStatePropertyAll(DarkTheme.primaryColor),
        textStyle: MaterialStatePropertyAll(
          TextStyle(
              fontSize: fontSize.mediumBodyFontSize,
              fontWeight: FontWeight.bold),
        ),
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
      ),
    ),
  );
}
