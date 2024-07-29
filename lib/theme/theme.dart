import 'package:flutter/material.dart';

class DoDidDoneTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF9f7bf6), // Primary color
      brightness: Brightness.light,
      primary: const Color(0xFF9F7BF6),  // Primary color
      secondary: const Color(0xFF4ceb8b),  // Secondary color
    ),
    useMaterial3: true,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Color(0xFF5839A1), // Primary Icon
      unselectedItemColor: Color(0xFF555555), // Secondary Icon
    ),
    cardColor: Colors.white,
  );
}
