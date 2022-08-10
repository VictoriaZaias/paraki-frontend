import 'package:flutter/material.dart';

import '../http/EstacionamentoService.dart';
import '../models/Reserva.dart';

class CardReserva extends StatelessWidget {
  final Reserva reserva;

  const CardReserva({
    Key? key,
    required this.reserva,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: ListTile(
          textColor: Colors.black,
          leading: Icon(
            Icons.calendar_month,
            size: 80.0,
            color: Color(0xFFB497F2),
          ),
          title: Text("Reserva " +
              reserva.idReserva.toString() +
              " - " +
              reserva.vaga!),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(reserva.estacionamento!.nomeEstacionamento!),
                Text(EstacionamentoService()
                    .enderecoCompleto(reserva.estacionamento!)),
                Text("Telefone: " + reserva.estacionamento!.telefone!),
                Text("Dia: " +
                    reserva.dataReserva! +
                    "     " +
                    "Horário: " +
                    reserva.horarioEntrada! +
                    " - " +
                    reserva.horarioSaida!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
