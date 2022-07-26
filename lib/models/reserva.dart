import 'package:estacionamento/models/Estacionamento.dart';
import 'package:estacionamento/models/Usuario.dart';

class Reserva {
  final int? idReserva;
  final String? dataReserva;
  final String? horarioEntrada;
  final String? horarioSaida;
  //final Usuario? usuario;
  //final Estacionamento? estacionamento;
  //final double? precoHora;
  //final double valorTotal;
  //final int vaga;

  Reserva(
    this.idReserva,
    this.dataReserva,
    this.horarioEntrada,
    this.horarioSaida,
    //this.usuario,
    ///this.estacionamento,
    //this.precoHora,
  );
}
