import 'package:estacionamento/components/Button.dart';
import 'package:estacionamento/components/ContainerDados.dart';
import 'package:flutter/material.dart';
import '../components/TopoPadrao.dart';
import '../http/EstacionamentoService.dart';
import '../models/Reserva.dart';
import 'AcaoBemSucedida.dart';

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
        children: [
          ContainerDados(
            titulo: reserva.estacionamento!.nomeEstacionamento,
            dados: [
              Text(EstacionamentoService()
                  .enderecoCompleto(reserva.estacionamento!)),
            ],
          ),
          ContainerDados(
            titulo: "Reserva",
            dados: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Dia"),
                  Text(reserva.dataReserva!),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Entrada"),
                  Text(reserva.horarioEntrada!),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Saída"),
                  Text(reserva.horarioSaida!),
                ],
              ),
            ],
          ),
          ContainerDados(
            titulo: "Total",
            dados: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [],
              )
            ],
          ),
          Button(
            rotulo: "Pagamento",
            onPressed: () async {
              /*
              PaymentResult result =
                  await MercadoPagoMobileCheckout.startCheckout(
                "TEST-289dbf5a-95ae-4c1c-a067-f68578724676",
                preferenceId,
              );
              print(result.toString());
              */
/*
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AcaoBemSucedida("Reserva feita com sucesso!"),
                ),
              );*/
            },
          ),
        ],
      ),
    );
  }
}
