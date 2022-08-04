import 'package:estacionamento/components/CardEstacionamentoEsqueleto.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import '../models/Endereco.dart';
import '../models/Estacionamento.dart';
import 'CardEstacionamento.dart';
import 'CenteredMessage.dart';

class ListaEstacionamento extends StatefulWidget {
  var buscar;

  ListaEstacionamento(
    this.buscar,
  );

  @override
  State<ListaEstacionamento> createState() => _ListaEstacionamentoState();
}

class _ListaEstacionamentoState extends State<ListaEstacionamento> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<Estacionamento>>(
        future: widget.buscar,
        builder: (context, AsyncSnapshot<List<Estacionamento>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => CardEstacionamentoEsqueleto(),
              );
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
                        estacionamento: estacionamento,
                      );
                    },
                    itemCount: estacionamentos.length,
                  );
                }
              }
              return CenteredMessage(
                'Nenhum estacionamento encontrado',
                icon: Icons.block,
              );
          }
          return CenteredMessage('Unknown error');
        },
      ),
    );
  }
}
