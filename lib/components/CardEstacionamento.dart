import 'package:estacionamento/http/estacionamentoService.dart';
import 'package:estacionamento/models/Estacionamento.dart';
import 'package:flutter/material.dart';

import '../screens/DadosEstacionamento.dart';
import 'ActionButton.dart';

class CardEstacionamento extends StatelessWidget {
  final Estacionamento estacionamento;

  const CardEstacionamento({Key? key, required this.estacionamento})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: Card(
        child: ListTile(
          leading: ActionButton(
            padding: 0.0,
            tamanhoBotao: 70.0,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DadosEstacionamento(
                            estacionamento: estacionamento,
                          )));
            },
          ),
          title: Text(estacionamento.nomeEstacionamento),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(enderecoCompleto(estacionamento)),
              Text("Quantidade de vagas: " +
                  estacionamento.qtdTotalVagas.toString()),
              Text("Valor por hora: " + estacionamento.valorHora.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
