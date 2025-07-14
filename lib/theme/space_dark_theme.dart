import 'package:flutter/material.dart';

final ThemeData spaceDarkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF0B0C10),
  primaryColor: const Color(0xFF5C2A9D),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF5C2A9D),
    secondary: Color(0xFF66FCF1),
    background: Color(0xFF1F2833),
    surface: Color(0xFF0B0C10),
    onPrimary: Colors.white,
    onSecondary: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1F2833),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF66FCF1)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF5C2A9D),
      foregroundColor: Colors.white,
    ),
  ),
);
