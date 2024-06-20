import 'package:chat_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeClass {
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFDC5F00),
      secondary: Color(0xFF373A40),
      surface: Color(0xFFEEEEEE),
      shadow: Color(0xFF686D76),
    ),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: MyColors.secondary,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: MyColors.shadow,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: MyColors.shadow,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: MyColors.shadow,
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 8,
        fontWeight: FontWeight.w300,
        color: MyColors.shadow,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFEBD9CA),
      hintStyle: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: MyColors.shadow,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: MyColors.primary,
          width: 2,
        ),
      ),
    ),
  );
}
