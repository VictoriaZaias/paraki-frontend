import 'package:estacionamento/components/ContainerDados.dart';
import 'package:flutter/material.dart';
import '../components/TopoPadrao.dart';
import '../http/EstacionamentoService.dart';
import '../models/Reserva.dart';

class Pagamento extends StatelessWidget {
  final Reserva reserva;

  const Pagamento({
    Key? key,
    required this.reserva,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopoPadrao(
        titulo: "Pagamento",
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContainerDados(
              titulo: reserva.estacionamento!.nomeEstacionamento,
              dados: [/*
                Text(EstacionamentoService()
                    .enderecoCompleto(reserva.estacionamento!)),*/
              ]),
          Text("Dados estaciconamento, horario da reserva"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Subtotal:"),
              Text("reserva.valorTotal"),
            ],
          )
        ],
      ),
    );
  }
}
