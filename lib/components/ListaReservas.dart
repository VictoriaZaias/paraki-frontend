import 'package:flutter/material.dart';
import '../http/ReservaService.dart';
import '../models/Reserva.dart';
import '../models/Usuario.dart';
import 'CardEsqueleto.dart';
import 'CardReserva.dart';
import 'CenteredMessage.dart';
/*
class ListaReservas extends StatefulWidget {
  final Usuario user;

  const ListaReservas({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ListaReservas> createState() => _ListaReservasState();
}

class _ListaReservasState extends State<ListaReservas> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<Reserva>>(
        future: ReservaService().listarReservas(widget.user.idUsuario!),
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
    );
  }
}
*/