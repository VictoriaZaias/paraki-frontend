import 'package:estacionamento/http/EstacionamentoService.dart';
import 'package:estacionamento/models/Estacionamento.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:async';

import '../screens/DadosEstacionamento.dart';
import 'ActionButton.dart';

class CardEstacionamento extends StatelessWidget {
  final Estacionamento estacionamento;

  const CardEstacionamento({
    Key? key,
    required this.estacionamento,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: ListTile(
          textColor: Colors.black,
          leading: Stack(
            alignment: Alignment.center,
            children: [
              ActionButton(
                padding: 0.0,
                tamanhoBotao: 70.0,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DadosEstacionamento(
                              estacionamento: estacionamento)));
                },
              ),
            ],
          ),
          title: Text(estacionamento.nomeEstacionamento),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(EstacionamentoService().enderecoCompleto(estacionamento)),
                Text("Quantidade de vagas disponíveis: " +
                    estacionamento.qtdVagasDisponiveis.toString()),
                Text("Valor por hora: " + estacionamento.valorHora.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
