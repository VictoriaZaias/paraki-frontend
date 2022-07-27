import 'package:estacionamento/screens/PrincipalAdmin.dart';
import 'package:flutter/material.dart';
import '../components/ActionButton.dart';

class Agradecimento extends StatelessWidget {
  final String acao;

  const Agradecimento(
    this.acao, {
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
              "Motorista $acao com sucesso!",
              style: TextStyle(fontSize: 36.0),
              textAlign: TextAlign.center,
            ),
            ActionButton(
              padding: 0.0,
              tamanhoBotao: 120.0,
              onPressed: () {
                if (acao == "cadastrado") {
                  Navigator.pop(context);
                }
                //Navigator.popUntil(context, ModalRoute.withName("/tres"));
                //Navigator.of(context).popUntil(ModalRoute.withName("PrincipalAdmin"));
              },
            ),
          ],
        ),
      ),
    );
  }
}
