import 'package:estacionamento/http/HorarioFuncionamentoService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/HorarioFuncionamento.dart';
import 'CenteredMessage.dart';
import 'Progress.dart';

class ListaHorariosFuncionamento extends StatefulWidget {
  final int idEstacionamento;
  final int tamanho;

  const ListaHorariosFuncionamento(
    this.idEstacionamento, {
    Key? key,
    this.tamanho = 0,
  }) : super(key: key);

  @override
  State<ListaHorariosFuncionamento> createState() =>
      _ListaHorariosFuncionamentoState();
}

class _ListaHorariosFuncionamentoState
    extends State<ListaHorariosFuncionamento> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FutureBuilder<List<HorarioFuncionamento>>(
        future: HorarioFuncionamentoService()
            .listarHorarios(widget.idEstacionamento),
        builder: (context, AsyncSnapshot<List<HorarioFuncionamento>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<HorarioFuncionamento> horarioFuncionamentos =
                    snapshot.data ?? [];
                if (horarioFuncionamentos.isNotEmpty) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      int tamanho = 0;
                      final HorarioFuncionamento horarioFuncionamento =
                          horarioFuncionamentos[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(horarioFuncionamento.diaSemana + ":"),
                          Text(horarioFuncionamento.horarioInicio +
                              " - " +
                              horarioFuncionamento.horarioFim),
                        ],
                      );
                      tamanho = horarioFuncionamentos.length;
                    },
                    itemCount: horarioFuncionamentos.length,
                  );
                }
              }
              return CenteredMessage(
                'Nenhuma HorarioFuncionamento encontrada',
                icon: Icons.block,
              );
          }
          return CenteredMessage('Unknown error');
        },
      ),
    );
  }
}
