import 'package:estacionamento/http/EstacionamentoService.dart';
import 'package:estacionamento/models/Estacionamento.dart';
import 'package:flutter/material.dart';
import 'CardEstacionamento.dart';
import 'CenteredMessage.dart';
import 'Progress.dart';

class ListaEstacionamento extends StatefulWidget {
  const ListaEstacionamento({Key? key}) : super(key: key);

  @override
  State<ListaEstacionamento> createState() => _ListaEstacionamentoState();
}

class _ListaEstacionamentoState extends State<ListaEstacionamento> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<Estacionamento>>(
        future: listarEstacionamento(),
        builder:
            (context, AsyncSnapshot<List<Estacionamento>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Estacionamento> estacionamentos =
                    snapshot.data ?? [];
                if (estacionamentos.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Estacionamento estacionamento =
                          estacionamentos[index];
                      return CardEstacionamento(
                        /*idEstacionamento: estacionamento.idEstacionamento,
                        nomeEstacionamento: estacionamento.nomeEstacionamento,
                        cnpj: estacionamento.cnpj,
                        qtdTotalVagas: estacionamento.qtdTotalVagas,
                        nroEstacionamento: estacionamento.nroEstacionamento,
                        valorHora: estacionamento.valorHora,
                        telefone: estacionamento.telefone,
                        endereco: enderecoCompleto(estacionamento),*/
                        estacionamento: estacionamento,
                      );
                    },
                    itemCount: estacionamentos.length,
                  );
                }
              }
              return CenteredMessage(
                'Nenhum Estacionamento encontrado',
                icon: Icons.block,
              );
          }
          return CenteredMessage('Unknown error');
        },
      ),
    );
  }
}
