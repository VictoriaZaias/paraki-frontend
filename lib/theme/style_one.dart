import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    appBarTheme: const AppBarTheme(
      color: Color(0xFFB497F2),
    ),
    scaffoldBackgroundColor: const Color(0xFF8A67EF),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(
        color: Color(0xFF535257),
      ),
      filled: true,
      fillColor: Color(0xFFEDE4E2),
    ),
    elevatedButtonTheme: buttonTheme(),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor:
            MaterialStateProperty.all<Color>(const Color(0xFFEDE4E2)),
      ),
    ),
  );
}

ElevatedButtonThemeData buttonTheme() {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor:
          MaterialStateProperty.all<Color>(const Color(0xFFEDE4E2)),
      backgroundColor:
          MaterialStateProperty.all<Color>(const Color(0xFF411884)),
    ),
  );
}
