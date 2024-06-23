import 'package:chat_app/core/theme/colors.dart';
import 'package:chat_app/core/theme/elevated_button_theme.dart';
import 'package:chat_app/core/theme/input_decoration_theme.dart';
import 'package:chat_app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeClass {
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: MyColors.primary,
      secondary: MyColors.secondary,
      surface: MyColors.surface,
      shadow: MyColors.shadow,
    ),
    textTheme: MyTextTheme.myTextTheme,
    inputDecorationTheme: MyInputDecorationTheme.myInputDecorationTheme,
    elevatedButtonTheme: MyElevatedfButtonTheme.myElevatedfButtonTheme,
  );
}
