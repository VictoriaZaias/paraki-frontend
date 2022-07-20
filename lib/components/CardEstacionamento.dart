import 'package:flutter/material.dart';

import '../screens/DadosEstacionamento.dart';
import 'ActionButton.dart';

class CardEstacionamento extends StatelessWidget {
  final String nomeEstacionamento;
  final String quantidadeTotalVagas;
  final int valorHora;

  const CardEstacionamento({
    Key? key,
    required this.nomeEstacionamento,
    required this.quantidadeTotalVagas,
    required this.valorHora
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: Card(
        child: ListTile(
          leading: ActionButton(
            padding: 0.0,
            tamanhoBotao: 70.0,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DadosEstacionamento()));
            
            
            },
          ),
          /*
          Icon(
            Icons.circle,
            size: 70.0,
            color: Color(0xFF411884),
          ),*/
          title: Text(nomeEstacionamento),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(valorHora.toString()),
              Text(quantidadeTotalVagas),
            ],
          ),
        ),
      ),
    );
  }
}
