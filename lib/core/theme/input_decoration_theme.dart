import 'package:chat_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyInputDecorationTheme {
  static final myInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFEBD9CA),
    hintStyle: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: MyLightColors.shadow,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: MyLightColors.primary,
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: MyLightColors.primary,
        width: 2,
      ),
    ),
  );

  static final myDarkInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFEBD9CA),
    hintStyle: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: MyDarkColors.secondary,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: MyDarkColors.primary,
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: MyDarkColors.primary,
        width: 2,
      ),
    ),
  );
}
