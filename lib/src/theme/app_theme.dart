import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: const Color(0xFF40C4FF), // Telegram sky blue
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF40C4FF), // Sky blue for primary elements
      secondary: Colors.grey, // Secondary color for message bubbles
    ),
    scaffoldBackgroundColor: Colors.white, // Telegram white background
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black54),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF40C4FF), // Sky blue for FAB
      foregroundColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF40C4FF), // Sky blue for app bar
      foregroundColor: Colors.white,
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: const Color(0xFF40C4FF), // Telegram sky blue
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF40C4FF), // Sky blue for primary elements
      secondary: Colors.grey, // Secondary color for message bubbles
    ),
    scaffoldBackgroundColor: Colors.grey[900], // Dark mode background
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white70),
      bodyMedium: TextStyle(color: Colors.white54),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF40C4FF), // Sky blue for FAB
      foregroundColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF40C4FF), // Sky blue for app bar
      foregroundColor: Colors.white,
    ),
  );
  }