<<<<<<< Updated upstream
=======
import 'package:estacionamento/http/estacionamentoService.dart';
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'theme/style_one.dart';

void main() {
  runApp(const ParakiApp());
<<<<<<< Updated upstream
=======
  listarEstacionamento().then((estacionamentos) => print("novos usuarios $estacionamentos"));
>>>>>>> Stashed changes
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
