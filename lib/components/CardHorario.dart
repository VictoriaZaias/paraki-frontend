import 'package:estacionamento/http/HorarioFuncionamentoService.dart';
import 'package:estacionamento/models/HorarioFuncionamento.dart';
import 'package:flutter/material.dart';

import 'ActionButton.dart';

class CardHorario extends StatelessWidget {
  final HorarioFuncionamento horarioFuncionamento;

  const CardHorario({Key? key, required this.horarioFuncionamento})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: Card(
        child: ListTile(
          textColor: Colors.black,
          leading: Stack(
            alignment: Alignment.center,
          ),
          title: Text("ajsdijasidjiasjdijas"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("PPPPP: " +
                  horarioFuncionamento.diaSemana),
              Text("lllll" + horarioFuncionamento.horarioInicio),
            ],
          ),
        ),
      ),
    );
  }
}
