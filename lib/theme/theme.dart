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
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: const Color(0xFF9F7BF6), // Основной цвет
      unselectedItemColor: Colors.grey, // Серый цвет для неактивных иконок
    ),
  );
}

// import 'package:flutter/material.dart';

// class DoDidDoneTheme {
//   static ThemeData lightTheme = ThemeData(
//     colorScheme: ColorScheme.fromSeed(
//       seedColor: const Color(0xFF9f7bf6), // Primary color
//       brightness: Brightness.light,
//       primary: const Color(0xFF9F7BF6),  // Primary color
//       secondary: const Color(0xFF4ceb8b),  // Secondary color
//     ),
//     useMaterial3: true,
//   )
//   ;
// }
