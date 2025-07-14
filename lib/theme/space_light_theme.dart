import 'package:flutter/material.dart';

final ThemeData spaceLightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: const Color(0xFF5C2A9D),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF5C2A9D),
    secondary: Color(0xFF66FCF1),
    background: Colors.white,
    surface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF5C2A9D),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.black87),
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF5C2A9D)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF5C2A9D),
      foregroundColor: Colors.white,
    ),
  ),
);
