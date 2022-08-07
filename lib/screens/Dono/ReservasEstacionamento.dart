import 'package:estacionamento/models/Estacionamento.dart';
import 'package:flutter/material.dart';
import '../../components/ActionButton.dart';
import '../../components/CardEsqueleto.dart';
import '../../components/CardReserva.dart';
import '../../components/CenteredMessage.dart';
import '../../components/TopoPadrao.dart';
import '../../http/ReservaService.dart';
import '../../models/Reserva.dart';

class ReservasEstacionamento extends StatefulWidget {
  final Estacionamento estacionamento;

  const ReservasEstacionamento({
    Key? key,
    required this.estacionamento,
  }) : super(key: key);

  @override
  State<ReservasEstacionamento> createState() => _ReservasEstacionamentoState();
}

class _ReservasEstacionamentoState extends State<ReservasEstacionamento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(95.0),
        child: AppBar(
          centerTitle: true,
          toolbarHeight: 90.0,
          leadingWidth: 90.0,
          leading: ActionButton(
            simbolo: Icons.arrow_back,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Column(
            children: [
              Text(
                "Reservas",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 19.0,
                ),
              ),
              Text(
                widget.estacionamento.nomeEstacionamento!,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 19.0,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Reserva>>(
              future: ReservaService().listarReservasEstacionamento(
                  widget.estacionamento.idEstacionamento!),
              builder: (context, AsyncSnapshot<List<Reserva>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    break;
                  case ConnectionState.waiting:
                    return ListView.builder(
                      itemCount: 6,
                      itemBuilder: (context, index) => CardEsqueleto(
                        icone: Icon(
                          Icons.calendar_month,
                          size: 80.0,
                        ),
                      ),
                    );
                  case ConnectionState.active:
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      final List<Reserva> reservas = snapshot.data ?? [];
                      if (reservas.isNotEmpty) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final Reserva reserva = reservas[index];
                            return CardReserva(
                              reserva: reserva,
                            );
                          },
                          itemCount: reservas.length,
                        );
                      }
                    }
                    return CenteredMessage(
                      'Nenhuma reserva encontrada',
                      icon: Icons.block,
                    );
                }
                return CenteredMessage('Unknown error');
              },
            ),
          ),
        ],
      ),
    );
  }
}
