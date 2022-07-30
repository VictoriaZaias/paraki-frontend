import 'package:estacionamento/http/EstacionamentoService.dart';
import 'package:estacionamento/models/Estacionamento.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:async';

import '../http/PeriodicRequester.dart';
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
    return GestureDetector(
      child: SizedBox(
        child: Card(
          child: ListTile(
            textColor: Colors.black,
            leading: Stack(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  color: Colors.amber,
                ),
                /*
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
                */
                //showVagasDisponiveis(),
              ],
            ),
            title: Text(estacionamento.nomeEstacionamento),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      EstacionamentoService().enderecoCompleto(estacionamento)),
                  Text("Quantidade de vagas disponíveis: " +
                      estacionamento.qtdVagasDisponiveis.toString()),
                  Text(
                      "Valor por hora: " + estacionamento.valorHora.toString()),
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DadosEstacionamento(estacionamento: estacionamento)));
      },
    );
  }

  Widget showVagasDisponiveis() {
    return StreamBuilder<http.Response>(
      stream: PeriodicRequester.getVagasDisponiveis(),
      builder: (context, snapshot) => snapshot.hasData
          ? Text(
              snapshot.data!.body,
            )
          : Text(
              estacionamento.qtdVagasDisponiveis.toString(),
            ),
    );
  }
}
