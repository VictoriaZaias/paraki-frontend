import 'package:estacionamento/components/CheckboxCaracteristica.dart';
import 'package:estacionamento/http/CaracteristicaService.dart';
import 'package:estacionamento/models/Caracteristica.dart';
import 'package:flutter/material.dart';

import 'CenteredMessage.dart';
import 'Progress.dart';

class ListaCaracteristicas extends StatefulWidget {
  var buscar;
  //final int? tamanho;

  ListaCaracteristicas(
    this.buscar,
    //this.tamanho,
  );

  @override
  State<ListaCaracteristicas> createState() => _ListaCaracteristicasState();
}

class _ListaCaracteristicasState extends State<ListaCaracteristicas> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<Caracteristica>>(
        future: widget.buscar,
        builder: (context, AsyncSnapshot<List<Caracteristica>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Caracteristica> caracteristicas =
                    snapshot.data ?? [];
                if (caracteristicas.isNotEmpty) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final Caracteristica caracteristica =
                          caracteristicas[index];
                      return CheckboxCaracteristica(
                        caracteristica: caracteristica,
                      );
                    },
                    itemCount: caracteristicas.length,
                  );
                }
              }
              return CenteredMessage(
                'Nenhuma caracteristica encontrada',
                icon: Icons.block,
              );
          }
          return CenteredMessage('Unknown error');
        },
      ),
    );
  }
}
