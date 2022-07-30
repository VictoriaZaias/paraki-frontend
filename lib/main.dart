import 'dart:async';
import 'package:estacionamento/screens/CadastroEstacionamento.dart';
import 'package:estacionamento/screens/Login.dart';
import 'package:estacionamento/screens/Pagamento.dart';
import 'package:estacionamento/screens/Admin/PrincipalAdmin.dart';
import 'package:estacionamento/screens/PrincipalUsuario.dart';
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
      home: Pagamento(),
      title: 'Paraki',
      theme: appTheme(),
      debugShowCheckedModeBanner: false,
      routes: {
        'PrincipalAdmin': (context) => PrincipalAdmin(),
      },
    );
  }
}
