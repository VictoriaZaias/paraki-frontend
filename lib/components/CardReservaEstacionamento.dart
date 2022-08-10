import 'package:flutter/material.dart';

import '../models/Reserva.dart';

class CardReservaEstacionamento extends StatelessWidget {
  final Reserva reserva;

  const CardReservaEstacionamento({
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
                Text("Motorista: " + reserva.usuario!.nomeUsuario),
                Text("Dia: " +
                    reserva.dataReserva! +
                    "     " +
                    "Horário: " +
                    reserva.horarioEntrada! +
                    " - " +
                    reserva.horarioSaida!),
                Text("Preço: R\$" + reserva.valorTotal!.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
