import 'package:estacionamento/components/CheckboxCaracteristica.dart';
import 'package:estacionamento/http/CaracteristicaService.dart';
import 'package:estacionamento/models/Caracteristica.dart';
import 'package:flutter/material.dart';

import 'CenteredMessage.dart';
import 'Progress.dart';
/*
class ListaCaracteristicas extends StatefulWidget {
  var buscar;
  int tamanho;

  ListaCaracteristicas(
    this.buscar, {
    this.tamanho = 0,
  });

  @override
  State<ListaCaracteristicas> createState() => _ListaCaracteristicasState();
}
*/
/*
class _ListaCaracteristicasState extends State<ListaCaracteristicas> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Caracteristica>>(
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
              final List<Caracteristica> caracteristicas = snapshot.data ?? [];
              if (caracteristicas.isNotEmpty) {
                var l = ListView.builder(
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
                widget.tamanho = caracteristicas.length;
                print('ZZZZZZZZZZZZZZZ' + widget.tamanho.toString() + 'LLLLLLLLLLLLLLLLLLLLL');
                return l;
              }
            }
            return CenteredMessage(
              'Nenhuma caracteristica encontrada',
              icon: Icons.block,
            );
        }
        return CenteredMessage('Unknown error');
      },
    );
  }
}
*/

class ListaCaracteristicas extends StatelessWidget {
  var buscar;
  bool isCheckbox;

  ListaCaracteristicas(
    this.buscar, {
    Key? key,
    this.isCheckbox = false,
  }) : super(key: key);

  Future<List<Caracteristica>> caracteristicasFuture =
      CaracteristicaService().listarTodasCaracteristicas();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder<List<Caracteristica>>(
          future: buscar,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Progress();
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final caracteristicas = snapshot.data!;
                  return buildCaracteristicas(caracteristicas, isCheckbox);
                }
                return CenteredMessage(
                  'Nenhuma caracteristica encontrada',
                  icon: Icons.block,
                );
            }
            return CenteredMessage('Unknown error');
          }),
    );
  }

  Widget buildCaracteristicas(
      List<Caracteristica> caracteristicas, bool isCheckbox) {
    return ListView.builder(
      //physics: NeverScrollableScrollPhysics(),
      itemCount: caracteristicas.length,
      itemBuilder: (context, index) {
        final caracteristica = caracteristicas[index];
        if (isCheckbox) {
          return CheckboxCaracteristica(caracteristica: caracteristica);
        } else {
          return Row(
            children: [
              Text(caracteristica.caracteristica),
            ],
          );
        }
      },
    );
  }
}
