import 'package:estacionamento/http/HorarioFuncionamentoService.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
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
              return ListView.builder(
                itemCount: 7,
                itemBuilder: (context, index) => horariosEsqueleto(context),
              );
            case ConnectionState.active:
              break;

            case ConnectionState.done:
              if (snapshot.hasData) {
                final horariosFuncionamento = snapshot.data!;
                return buildHorariosFuncionamento(horariosFuncionamento);
              }
              return CenteredMessage(
                'Nenhum horario encontrado',
                icon: Icons.block,
              );
          }
          return CenteredMessage('Unknown error');
        },
      ),
    );
  }

  Widget buildHorariosFuncionamento(
      List<HorarioFuncionamento> horariosFuncionamento) {
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

  Widget horariosEsqueleto(BuildContext context) {
    return SkeletonItem(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          randomLength: true,
                          height: 14,
                          borderRadius: BorderRadius.circular(8),
                          minLength: MediaQuery.of(context).size.width / 5,
                          maxLength: MediaQuery.of(context).size.width / 3,
                        ),
                      ),
                      Row(
                        children: [
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              width: 55,
                              height: 14,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          SizedBox(width: 8),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              width: 55,
                              height: 14,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
