import 'package:flutter/material.dart';

Color _roxolele = const Color(0xFF8A67EF);
Color _lilili = const Color(0xFFB497F2);
Color _roxedao = const Color(0xFF411884);
Color _branquin = const Color(0xFFEDE4E2);
//Color _cinzinha = const Color(0xFF535257);
Color _pretao = Colors.black;

ThemeData appTheme() {
  return ThemeData(
    // Fundos
    tabBarTheme: TabBarTheme(
      labelColor: _lilili,
    ),
    cardTheme: CardTheme(
      color: _branquin,
    ),
    appBarTheme: AppBarTheme(
      color: _lilili,
    ),
    scaffoldBackgroundColor: _roxolele,
    // Fundos

    // Letras
    fontFamily: 'Poppins',
    listTileTheme: ListTileThemeData(
      textColor: _branquin,
    ),
    inputDecorationTheme: InputDecorationTheme(
      iconColor: _pretao,
      hintStyle: TextStyle(
        color: _pretao,
      ),
      labelStyle: TextStyle(
        color: _pretao,
      ),
      filled: true,
      fillColor: _branquin,
    ),
    textTheme: TextTheme(
      bodyText2: TextStyle(
        color: _branquin,
      ),
    ),
    // Letras

    // Botões
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all<Color>(_branquin),
      checkColor: MaterialStateProperty.all<Color>(_roxedao),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(_pretao),
        backgroundColor: MaterialStateProperty.all<Color>(_branquin),
        side:
            MaterialStateProperty.all<BorderSide>(BorderSide(color: _branquin)),
      ),
    ),
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
