import 'package:estacionamento/components/Testando.dart';
import 'package:flutter/material.dart';
import '../models/Estacionamento.dart';
import 'Testando.dart';
import 'CenteredMessage.dart';
import 'Progress.dart';

class ListaEstacionamento extends StatefulWidget {
  var buscar;
  ListaEstacionamento(this.buscar);

  
  @override
  State<ListaEstacionamento> createState() => _ListaEstacionamentoState();
  
}

class _ListaEstacionamentoState extends State<ListaEstacionamento> {
  @override
  
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<Estacionamento>>(
        future: widget.buscar,
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
                      return Testando(
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
