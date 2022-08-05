import 'package:estacionamento/screens/Dono/CadastroEstacionamento.dart';
import 'package:estacionamento/screens/Inicial.dart';
import 'package:flutter/material.dart';
import 'screens/Admin/PrincipalAdmin.dart';
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
      home: Inicial(),
      title: 'Paraki',
      theme: appTheme(),
      debugShowCheckedModeBanner: false,
      routes: {
        'PrincipalAdmin': (context) => PrincipalAdmin(),
      },
    );
  }
}
