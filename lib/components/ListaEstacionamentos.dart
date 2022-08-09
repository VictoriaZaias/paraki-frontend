import 'package:estacionamento/components/CardEsqueleto.dart';
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
                itemBuilder: (context, index) => CardEsqueleto(
                  icone: Image.asset(
                    'assets/images/carro.png',
                    scale: 3,
                  ),
                ),
              );
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Estacionamento> estacionamentos =
                    snapshot.data ?? [];
                if (estacionamentos.isNotEmpty) {
                  return ListView.builder(
                    itemCount: estacionamentos.length,
                    itemBuilder: (context, index) {
                      final Estacionamento estacionamento =
                          estacionamentos[index];
                      return CardEstacionamento(
                        estacionamento: estacionamento,
                      );
                    },
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
