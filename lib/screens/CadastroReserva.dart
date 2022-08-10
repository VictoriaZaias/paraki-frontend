import 'package:estacionamento/components/DatePicker.dart';
import 'package:estacionamento/components/TimePicker.dart';
import 'package:estacionamento/http/ReservaService.dart';
import 'package:estacionamento/models/Reserva.dart';
import 'package:estacionamento/models/Usuario.dart';
import 'package:estacionamento/screens/Pagamento.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/Button.dart';
import '../components/ContainerDados.dart';
import '../components/TopoPadrao.dart';
import '../http/EstacionamentoService.dart';
import '../models/Estacionamento.dart';

class CadastroReserva extends StatefulWidget {
  final Estacionamento estacionamento;

  CadastroReserva({
    Key? key,
    required this.estacionamento,
  }) : super(key: key);

  @override
  State<CadastroReserva> createState() => _CadastroReservaState();
}

class _CadastroReservaState extends State<CadastroReserva> {
  NumberFormat numberFormat = new NumberFormat("00");
  DateTime selectedDate = DateTime.now();
  TimeOfDay timeEntrada = TimeOfDay.now();
  TimeOfDay timeSaida = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopoPadrao(
        titulo: "Reserva",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ContainerDados(
              titulo: widget.estacionamento.nomeEstacionamento,
              dados: [
                Text(EstacionamentoService()
                    .enderecoCompleto(widget.estacionamento)),
                Text("Telefone: " + widget.estacionamento.telefone!),
              ],
            ),
            ContainerDados(
              titulo: "Entrada",
              dados: [
                Row(
                  children: [
                    Text("Dia: "),
                    DatePicker(onDateChanged: (newDate) {
                      selectedDate = newDate;
                    }),
                  ],
                ),
                Row(
                  children: [
                    Text("Horário: "),
                    TimePicker(
                      onTimeChanged: (newTime) {
                        timeEntrada = newTime;
                      },
                    ),
                  ],
                ),
              ],
            ),
            ContainerDados(
              titulo: "Saída",
              dados: [
                Row(
                  children: [
                    Text("Horário: "),
                    TimePicker(
                      onTimeChanged: (newTime) {
                        timeSaida = newTime;
                      },
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Button(
                rotulo: "Última etapa",
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  Usuario usuario = Usuario(
                    prefs.getString('username')!,
                    prefs.getString('cpf')!,
                    prefs.getString('tipo_user')!,
                    prefs.getString('modelo_carro')!,
                    prefs.getString('senha_user')!,
                    idUsuario: prefs.getInt('id_user')!,
                  );

                  var dataReserva = selectedDate.year.toString() +
                      "-" +
                      selectedDate.month.toString() +
                      "-" +
                      selectedDate.day.toString();
                  var horarioEntrada = timeEntrada.hour.toString() +
                      ":" +
                      timeEntrada.minute.toString() +
                      ":00";
                  var horarioSaida = timeSaida.hour.toString() +
                      ":" +
                      timeSaida.minute.toString() +
                      ":00";
                  num valorTotal =
                      _calculaValorTotal(horarioEntrada, horarioSaida);
                  Reserva reserva = Reserva(
                    0,
                    dataReserva,
                    horarioEntrada,
                    horarioSaida,
                    usuario: usuario,
                    estacionamento: widget.estacionamento,
                    valorTotal: valorTotal.toDouble(),
                  );
                  print('---------------------');
                  print(reserva.horarioEntrada.toString() +
                      reserva.horarioSaida.toString());
                  print('---------------------------------');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Pagamento(
                        reserva: reserva,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  num _calculaValorTotal(String start_time, String end_time) {
    var format = DateFormat("HH:mm");
    var start = format.parse(start_time);
    var end = format.parse(end_time);

    Duration diff = end.difference(start);
    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;
    return (diff.inHours + minutes / 60) * widget.estacionamento.valorHora!;
  }
}
