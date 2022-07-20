import 'package:estacionamento/http/estacionamentoService.dart';
import 'package:estacionamento/models/Endereco.dart';
import 'package:estacionamento/models/Estacionamento.dart';
import 'package:flutter/material.dart';

import '../screens/DadosEstacionamento.dart';
import 'ActionButton.dart';

class CardEstacionamento extends StatelessWidget {
  /*final int idEstacionamento;
  final String nomeEstacionamento;
  final String cnpj;
  final int qtdTotalVagas;
  final int nroEstacionamento;
  final String telefone;
  final int valorHora;
  final String endereco;*/
  final Estacionamento estacionamento;

  const CardEstacionamento({
    Key? key,
    /*required this.idEstacionamento,
    required this.nomeEstacionamento,
    required this.cnpj,
    required this.qtdTotalVagas,
    required this.nroEstacionamento,
    required this.telefone,
    required this.valorHora,
    required this.endereco*/
    required this.estacionamento
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
                      builder: (context) => DadosEstacionamento(estacionamento: estacionamento,)));
            
            
            },
          ),
          /*
          Icon(
            Icons.circle,
            size: 70.0,
            color: Color(0xFF411884),
          ),*/
          title: Text(estacionamento.nomeEstacionamento),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Quantidade de vagas: "+estacionamento.qtdTotalVagas.toString()),
              Text("Valor por hora: "+estacionamento.valorHora.toString()),
              Text(enderecoCompleto(estacionamento)),
            ],
          ),
        ),
      ),
    );
  }
}
