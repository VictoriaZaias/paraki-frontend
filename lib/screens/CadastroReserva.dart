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
                  Reserva reserva = Reserva(
                    0,
                    dataReserva,
                    horarioEntrada,
                    horarioSaida,
                    usuario,
                    estacionamento: widget.estacionamento,
                    //widget.estacionamento.valorHora,
                  );
                  print('---------------------');
                  print(reserva.horarioEntrada.toString() +
                      reserva.horarioSaida.toString());
                  print('---------------------------------');
                  ReservaService().cadastrarReserva(
                    reserva,
                    widget.estacionamento.valorHora!,
                    widget.estacionamento.idEstacionamento!,
                  );
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
}
