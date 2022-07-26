import 'package:estacionamento/models/Estacionamento.dart';
import 'package:estacionamento/models/Usuario.dart';

class Reserva{
  final int idReserva;
  final String dataReserva;
  final String horarioEntrada;
  final String horarioSaida;
  final Usuario usuario;
  final Estacionamento estacionamento;
  final double precoHora;
  //final double valorTotal;
  //final int vaga; 

Reserva(
  {
    required this.idReserva,
    required this.dataReserva,
    required this.horarioEntrada,
    required this.horarioSaida,
    required this.usuario,
    required this.estacionamento,
    required this.precoHora
  }
);


}