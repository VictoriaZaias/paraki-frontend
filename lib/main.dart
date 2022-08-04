import 'package:estacionamento/screens/AcaoBemSucedida.dart';
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
      home: Login(),
      title: 'Paraki',
      theme: appTheme(),
      debugShowCheckedModeBanner: false,
      routes: {
        'PrincipalAdmin': (context) => PrincipalAdmin(),
      },
    );
  }
}
