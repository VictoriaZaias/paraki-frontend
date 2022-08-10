import 'package:estacionamento/models/Estacionamento.dart';
import 'package:estacionamento/models/Usuario.dart';

class Reserva {
  final int? idReserva;
  final String? dataReserva;
  final String? horarioEntrada;
  final String? horarioSaida;
  final Usuario? usuario;
  final Estacionamento? estacionamento;
  final String? vaga;
  final double? valorTotal;

  Reserva(
    this.idReserva,
    this.dataReserva,
    this.horarioEntrada,
    this.horarioSaida,
    {
    this.usuario,
    this.estacionamento,
    this.vaga,
    this.valorTotal,
    }
  );
  
  @override
  String toString() {
    return 'Reserva{id: $idReserva, data: $dataReserva, entrada: $horarioEntrada, saida: $horarioSaida, vaga: $vaga}';
  }
}
