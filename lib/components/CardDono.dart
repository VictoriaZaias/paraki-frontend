import 'package:estacionamento/screens/Dono/ReservasEstacionamento.dart';
import 'package:flutter/material.dart';
import '../http/EstacionamentoService.dart';
import '../models/Estacionamento.dart';
import '../screens/DadosEstacionamento.dart';

class CardDono extends StatelessWidget {
  final Estacionamento estacionamento;

  const CardDono({
    Key? key,
    required this.estacionamento,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              estacionamento.nomeEstacionamento!,
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Text(
              EstacionamentoService().enderecoCompleto(estacionamento),
              style: TextStyle(color: Colors.black),
            ),
          ),
          Row(
            children: [
              Spacer(),
              TextButton(
                child: const Text(
                  'Dados',
                  style: TextStyle(color: Color(0xFF411884)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DadosEstacionamento(estacionamento: estacionamento),
                    ),
                  );
                },
              ),
              Spacer(),
              TextButton(
                child: const Text(
                  'Reservas',
                  style: TextStyle(color: Color(0xFF411884)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReservasEstacionamento(
                          estacionamento: estacionamento),
                    ),
                  );
                },
              ),
              Spacer(),
            ],
          )
        ],
      ),
    );
  }
}
