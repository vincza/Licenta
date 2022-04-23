import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme() {
  return ThemeData(
    colorScheme: ColorScheme(
      primary: const Color(0xFFffffff),
      primaryContainer: const Color(0xFFF5F5DC),
      secondary: Colors.deepOrange.shade600,
      secondaryContainer: const Color(0xFF0B0BFF),
      surface: const Color(0xFF000000),
      background: const Color(0xFF0D0C11),
      error: const Color(0xFFf20900),
      onPrimary: const Color(0xFF363636),
      onSecondary: const Color(0xFFffffff),
      onSurface: const Color(0xFFffffff),
      onBackground: const Color(0xFFffffff),
      onError: const Color(0xFFffffff),
      brightness: Brightness.light,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: const Color(0xFF363636).withOpacity(0.2),
    ),
    textTheme: TextTheme(
      headline1: GoogleFonts.montserrat(
        color: const Color(0xFF0D0C11),
      ),
      bodyText1: GoogleFonts.openSans(
        color: const Color(0xFF0D0C11),
      ),
    ),
  );
}

ThemeData lightTheme() {
  return ThemeData();
}
