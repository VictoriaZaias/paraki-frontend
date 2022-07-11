import 'package:flutter/material.dart';

Color _roxolele = const Color(0xFF8A67EF);
Color _lilili = const Color(0xFFB497F2);
Color _roxedao = const Color(0xFF411884);
Color _branquin = const Color(0xFFEDE4E2);
Color _cinzinha = const Color(0xFF535257);

ThemeData appTheme() {
  return ThemeData(
    // Fundos
    appBarTheme: AppBarTheme(
      color: _lilili,
    ),
    scaffoldBackgroundColor: _roxolele,
    // Fundos

    // Letras
    //fontFamily: "Poppins",
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: Colors.black,
      ),
      labelStyle: TextStyle(
        color: Colors.black,
      ),
      filled: true,
      fillColor: _branquin,
    ),
    textTheme: TextTheme(
      bodyText2: TextStyle(
        color: Colors.red,
      ),
    ),
    // Letras

    // Botões
    elevatedButtonTheme: buttonTheme(),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: _branquin,
      backgroundColor: _roxedao,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(_branquin),
      ),
    ),
    // Botões
  );
}

ElevatedButtonThemeData buttonTheme() {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(_branquin),
      backgroundColor: MaterialStateProperty.all<Color>(_roxedao),
    ),
  );
}
