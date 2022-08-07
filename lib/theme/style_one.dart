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
      indicator: BoxDecoration(
        color: _roxedao,
      ),
    ),
    cardTheme: CardTheme(
      color: _branquin,
    ),
    appBarTheme: AppBarTheme(
      color: _lilili,
    ),
    scaffoldBackgroundColor: _roxolele,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: _lilili, // Your accent color
    ),
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
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: _lilili,
      selectionColor: Color(0xFFE6E0F3),
      selectionHandleColor: _lilili,
    ),
    timePickerTheme: timeTheme(),
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
    //elevatedButtonTheme: buttonTheme(),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: _branquin,
      backgroundColor: _roxedao,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(_lilili),
      ),
    ),
    // Botões
  );
}

TimePickerThemeData timeTheme() {
  return TimePickerThemeData(
    hourMinuteColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.selected)
            ? Color(0xFFE6E0F3)
            : Color(0xFFD3D3D3)),
    hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.selected) ? _lilili : Colors.black),
    dialHandColor: _lilili,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    ),
    hourMinuteShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(0),
      //fillColor: Colors.pinkAccent,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFD3D3D3), width: 2),
        borderRadius: BorderRadius.circular(18.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _lilili, width: 2),
        borderRadius: BorderRadius.circular(18.0),
      ),
    ),
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
