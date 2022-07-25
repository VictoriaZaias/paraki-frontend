import 'package:estacionamento/http/EstacionamentoService.dart';
import 'package:estacionamento/models/Estacionamento.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:async';

import '../screens/DadosEstacionamento.dart';
import 'ActionButton.dart';

class Testando extends StatelessWidget {
  final Estacionamento estacionamento;

  const Testando({Key? key, required this.estacionamento})
      : super(key: key);

  Stream<String> getVagasDisponiveis() async* {
    yield* Stream.periodic(Duration(seconds: 5), (_) {
        get(Uri.parse(
          'https://estacionamento-pedepano.herokuapp.com/paraki/tests/getVagas'));
      return "asd";
    }).asyncMap((event) async => await event);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<http.Response>(
      stream: getVagasDisponiveis(),
      builder: (context, snapshot) => snapshot.hasData
          ? SizedBox(
              height: 150.0,
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
                      Text(
                        snapshot.data!.body
                      ),
                    ],
                  ),
                  title: Text(estacionamento.nomeEstacionamento),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(estacionamentoService()
                          .enderecoCompleto(estacionamento)),
                      Text("Quantidade de vagas disponíveis: " +
                          estacionamento.qtdVagasDisponiveis.toString()),
                      Text("Valor por hora: " +
                          estacionamento.valorHora.toString()),
                    ],
                  ),
                ),
              ),
            )
          : SizedBox(child: CircularProgressIndicator()),
    );
  }
}
