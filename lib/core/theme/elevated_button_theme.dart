import 'package:chat_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class MyElevatedfButtonTheme {
  static final myElevatedfButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll(
        MyColors.surface,
      ),
      minimumSize: const WidgetStatePropertyAll(
        Size(double.infinity, 55),
      ),
      foregroundColor: const WidgetStatePropertyAll(
        MyColors.secondary,
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
  );
}
