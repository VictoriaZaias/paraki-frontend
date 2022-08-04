import 'package:estacionamento/models/Estacionamento.dart';

class Reserva {
  final int? idReserva;
  final String? dataReserva;
  final String? horarioEntrada;
  final String? horarioSaida;
  final int? idUsuario;
  final Estacionamento? estacionamento;
  //final double? precoHora;
  //final double valorTotal;
  //final int vaga;

  Reserva(
    this.idReserva,
    this.dataReserva,
    this.horarioEntrada,
    this.horarioSaida,
    this.idUsuario, {
    this.estacionamento,
  }
      //this.precoHora,
      );
}
