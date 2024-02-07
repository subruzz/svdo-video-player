import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
  ),
  scaffoldBackgroundColor: Colors.black,
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: Colors.black,
  ),
  canvasColor: Colors.black,
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.montserrat(
      fontSize: 22,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: GoogleFonts.montserrat(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
    bodySmall: GoogleFonts.montserrat(
      fontSize: 19,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    labelLarge: GoogleFonts.montserrat(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: GoogleFonts.montserrat(
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: GoogleFonts.montserrat(
      fontSize: 12,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
  ),
);
final lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: Colors.white,
  ),
  canvasColor: Colors.white,
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.montserrat(
      fontSize: 22,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: GoogleFonts.montserrat(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    bodySmall: GoogleFonts.montserrat(
      fontSize: 19,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    labelLarge: GoogleFonts.montserrat(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: GoogleFonts.montserrat(
      fontSize: 14,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: GoogleFonts.montserrat(
      fontSize: 12,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
  ),
);
