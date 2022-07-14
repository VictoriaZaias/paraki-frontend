import 'package:flutter/material.dart';
import '../http/EstacionamentoService.dart';
import '../models/EstacionamentoEspecifico.dart';
import 'CardEstacionamento.dart';
import 'CenteredMessage.dart';
import 'Progress.dart';

class ListaEstacionamento extends StatelessWidget {
  const ListaEstacionamento({Key? key}) : super(key: key);

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
                final List<EstacionamentoEspecifico> Estacionamentos =
                    snapshot.data ?? [];
                if (Estacionamentos.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final EstacionamentoEspecifico Estacionamento =
                          Estacionamentos[index];
                      return CardEstacionamento(
                        nomeEstacionamento: Estacionamento.nomeEstacionamento,
                        quantidadeTotalVagas:
                            Estacionamento.quantidadeTotalVagas.toString(),
                      );
                    },
                    itemCount: Estacionamentos.length,
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
