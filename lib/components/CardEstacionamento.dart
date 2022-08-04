import 'dart:convert';

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
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 100,
                    maxWidth: 100,
                  ),
                  child: Image.asset(
                    'assets/images/carro.png',
                    scale: 2,
                  ),
                ),
                //showVagasDisponiveis(),
              ],
            ),
            title: Text(estacionamento.nomeEstacionamento!),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      EstacionamentoService().enderecoCompleto(estacionamento)),
                  Row(
                    children: [
                      Text("Valor por hora: R\$" +
                          estacionamento.valorHora.toString()),
                      Spacer(),
                      estacionamento.hasCarregamentoEletrico == true
                          ? Icon(
                              Icons.electric_car_rounded,
                              color: Colors.black,
                            )
                          : Icon(null),
                    ],
                  ),
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
        stream: PeriodicRequester.getVagasDisponiveis(
            estacionamento.idEstacionamento!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var json = jsonDecode(snapshot.data!.body);
            print("--------------------------------");
            print(json['result']['vagasLivres'].toString());
            print("--------------------------------");
            return Text(
              json['result']['vagasLivres'].toString(),
            );
          } else {
            return Text(
              "alo",
            );
          }
          return Text(
            "nada",
          );
        });
  }
}
