import 'package:estacionamento/http/estacionamentoService.dart';
import 'package:estacionamento/models/Estacionamento.dart';
import 'package:flutter/material.dart';

import '../components/ActionButton.dart';

class DadosEstacionamento extends StatelessWidget {
  final Estacionamento estacionamento;
  DadosEstacionamento({required this.estacionamento});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(95.0),
        child: AppBar(
          toolbarHeight: 90.0,
          leadingWidth: 90.0,
          leading: ActionButton(
            simbolo: Icons.arrow_back,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              //color: Color(0xFFEDE4E2),
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFB497F2),
                  width: 1.5,
                ),
              ),
            ),
            child: ListTile(
              title: Text(estacionamento.nomeEstacionamento),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(enderecoCompleto(estacionamento)),
                  Text("Telefone: "+estacionamento.telefone),
                  Text("CNPJ: "+estacionamento.cnpj),
                  Text("Quantidade de vagas: "+estacionamento.qtdTotalVagas.toString()),
                  Text("Valor por hora: "+estacionamento.valorHora.toString())
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
