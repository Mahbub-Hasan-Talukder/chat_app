import 'package:chat_app/core/theme/colors.dart';
import 'package:chat_app/core/theme/elevated_button_theme.dart';
import 'package:chat_app/core/theme/input_decoration_theme.dart';
import 'package:chat_app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: MyLightColors.primary,
      secondary: MyLightColors.secondary,
      surface: MyLightColors.surface,
      shadow: MyLightColors.shadow,
    ),
    textTheme: MyTextTheme.myLightTextTheme,
    inputDecorationTheme: MyInputDecorationTheme.myInputDecorationTheme,
    elevatedButtonTheme: MyElevatedfButtonTheme.myElevatedfButtonTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: MyDarkColors.primary,
      secondary: MyDarkColors.secondary,
      surface: MyDarkColors.surface,
      shadow: MyDarkColors.shadow,
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: MyLightColors.surface,
    ),
    textTheme: MyTextTheme.myDarkTextTheme,
    inputDecorationTheme: MyInputDecorationTheme.myDarkInputDecorationTheme,
    elevatedButtonTheme: MyElevatedfButtonTheme.myElevatedfButtonTheme,
  );
}
