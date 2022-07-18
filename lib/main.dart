import 'package:flutter/material.dart';
import 'screens/Login.dart';
import 'theme/style_one.dart';

void main() {
  runApp(const ParakiApp());
}

class ParakiApp extends StatelessWidget {
  const ParakiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Login(),
      title: 'Paraki',
      theme: appTheme(),
    );
  }
}
