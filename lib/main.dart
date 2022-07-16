import 'package:estacionamento/screens/PerfilUsuario.dart';
import 'package:flutter/material.dart';
import 'screens/Login.dart';
import 'screens/PrincipalUsuario.dart';
import 'theme/style_one.dart';

void main() {
  runApp(const ParakiApp());
}

class ParakiApp extends StatelessWidget {
  const ParakiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: const Login(),
      home: PerfilUsuario(),
      title: 'Paraki',
      theme: appTheme(),
    );
  }
}
