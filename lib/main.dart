import 'package:estacionamento/screens/AdminValidacao.dart';
import 'package:estacionamento/screens/Agradecimento.dart';
import 'package:estacionamento/screens/PrincipalAdmin.dart';
import 'package:estacionamento/screens/PrincipalUsuario.dart';
import 'package:estacionamento/screens/TestandoStreams.dart';
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
      home: PeriodicRequester(),
      title: 'Paraki',
      theme: appTheme(),
    );
  }
}
