import 'package:estacionamento/http/HorarioFuncionamentoService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/HorarioFuncionamento.dart';
import 'CenteredMessage.dart';
import 'Progress.dart';

class ListaHorariosFuncionamento extends StatelessWidget {
  final int idEstacionamento;

  ListaHorariosFuncionamento(
    this.idEstacionamento, {
    Key? key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150.0,
      child: FutureBuilder<List<HorarioFuncionamento>>(
        future: HorarioFuncionamentoService().listarHorarios(idEstacionamento),
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
                final horariosFuncionamento = snapshot.data!;
                return buildHorariosFuncionamento(horariosFuncionamento);
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

  Widget buildHorariosFuncionamento(List<HorarioFuncionamento> horariosFuncionamento) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: horariosFuncionamento.length,
      itemBuilder: (context, index) {
        final horarioFuncionamento = horariosFuncionamento[index];
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(horarioFuncionamento.diaSemana + ":"),
            Text(horarioFuncionamento.horarioInicio +
                " - " +
                horarioFuncionamento.horarioFim),
          ],
        );
      },
    );
  }
}
