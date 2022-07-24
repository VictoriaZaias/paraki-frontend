import 'dart:async';
import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';
import 'screens/Login.dart';
import 'theme/style_one.dart';

main() {
  runApp(const ParakiApp());
}

class ParakiApp extends StatelessWidget { 
  const ParakiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
      title: 'Paraki',
      theme: appTheme(),
    );
  }
}
