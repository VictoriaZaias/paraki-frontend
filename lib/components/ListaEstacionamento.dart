import 'package:flutter/material.dart';
import '../http/EstacionamentoService.dart';
import '../models/EstacionamentoEspecifico.dart';
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
      child: FutureBuilder<List<EstacionamentoEspecifico>>(
        future: listarEstacionamento(),
        builder:
            (context, AsyncSnapshot<List<EstacionamentoEspecifico>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<EstacionamentoEspecifico> estacionamentos =
                    snapshot.data ?? [];
                if (estacionamentos.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final EstacionamentoEspecifico estacionamento =
                          estacionamentos[index];
                      return CardEstacionamento(
                        nomeEstacionamento: estacionamento.nomeEstacionamento,
                        quantidadeTotalVagas:
                            estacionamento.quantidadeTotalVagas.toString(),
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
