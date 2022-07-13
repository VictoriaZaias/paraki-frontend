import 'package:estacionamento/models/usuario.dart';
import 'package:flutter/material.dart';
import 'http/usuarioService.dart';
import 'http/webClient.dart';
import 'screens/login.dart';
import 'theme/style_one.dart';

Future<void> main() async {
  runApp(const ParakiApp());
  listarUsuario().then((usuarios) => print("novos usuarios $usuarios"));
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
