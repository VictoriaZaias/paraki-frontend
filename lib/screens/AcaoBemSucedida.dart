import 'package:estacionamento/components/Button.dart';
import 'package:flutter/material.dart';

class AcaoBemSucedida extends StatelessWidget {
  final String mensagem;

  const AcaoBemSucedida(
    this.mensagem, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              mensagem,
              style: TextStyle(fontSize: 36.0),
              textAlign: TextAlign.center,
            ),
            Button(
              rotulo: "Página inicial",
              altura: 40.0,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
