import 'package:chat_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextTheme {
  static final myLightTextTheme = TextTheme(
    headlineLarge: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: MyLightColors.secondary,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: MyLightColors.shadow,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: MyLightColors.shadow,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      color: MyLightColors.secondary,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: MyLightColors.shadow,
    ),
  );
  static final myDarkTextTheme = TextTheme(
    headlineLarge: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: MyDarkColors.secondary,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: MyDarkColors.secondary,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: MyDarkColors.secondary,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      color: MyDarkColors.secondary,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: MyDarkColors.secondary,
    ),
  );
}
