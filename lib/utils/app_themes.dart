import 'package:flutter/material.dart';

class AppThemes {
  static const Color gold = Color(0xFFD4AF37);
  static const Color black = Color(0xFF262525);

  // LIGHT THEME (optional - keep minimal)
  static final light = ThemeData(
    brightness: Brightness.light,
    primaryColor: gold,
    scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
    colorScheme: ColorScheme.fromSeed(
      seedColor: gold,
      primary: gold,
      brightness: Brightness.light,
    ),
  );

  // DARK PREMIUM THEME
  static final dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: gold,
    scaffoldBackgroundColor: black,

    appBarTheme: const AppBarTheme(
      backgroundColor: black,
      elevation: 0,
      iconTheme: IconThemeData(color: gold),
    ),

    colorScheme: ColorScheme.fromSeed(
      seedColor: gold,
      primary: gold,
      brightness: Brightness.dark,
      surface: black,
    ),

    cardColor: const Color(0xFF1E1E1E),

   
  );
}