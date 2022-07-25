import 'package:flutter/material.dart';
import '../http/HorarioFuncionamentoService.dart';
import '../models/HorarioFuncionamento.dart';
import 'CardHorario.dart';
import 'CenteredMessage.dart';
import 'Progress.dart';

class ListaHorarios extends StatefulWidget {
  final int idEstacionamento;
  const ListaHorarios({Key? key, required this.idEstacionamento}) : super(key: key);

  @override
  State<ListaHorarios> createState() => _ListaHorariosState();
}

class _ListaHorariosState extends State<ListaHorarios> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<HorarioFuncionamento>>(
        future: HorarioFuncionamentoService().listarHorarios(widget.idEstacionamento),
        builder:
            (context, AsyncSnapshot<List<HorarioFuncionamento>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              print('SIM FDP');
              print(snapshot);
              print('aopa');
              if (snapshot.hasData) {
                print('OK');
                final List<HorarioFuncionamento> horarios =
                    snapshot.data ?? [];
                if (horarios.isNotEmpty) {
                  print('TAMO AQUI'); 
                  print(horarios);
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final HorarioFuncionamento horario =
                          horarios[index];
                      return CardHorario(
                        horarioFuncionamento: horario,
                      );
                    },
                    itemCount: horarios.length,
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
