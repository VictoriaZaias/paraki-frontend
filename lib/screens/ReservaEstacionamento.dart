import 'package:estacionamento/components/DatePicker.dart';
import 'package:estacionamento/components/TimePicker.dart';
import 'package:estacionamento/http/ReservaService.dart';
import 'package:estacionamento/models/Reserva.dart';
import 'package:estacionamento/screens/Pagamento.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/Button.dart';
import '../components/ContainerDados.dart';
import '../components/TopoPadrao.dart';
import '../http/EstacionamentoService.dart';
import '../models/Estacionamento.dart';

class ReservaEstacionamento extends StatefulWidget {
  final Estacionamento estacionamento;

  ReservaEstacionamento({
    Key? key,
    required this.estacionamento,
  }) : super(key: key);

  @override
  State<ReservaEstacionamento> createState() => _ReservaEstacionamentoState();
}

class _ReservaEstacionamentoState extends State<ReservaEstacionamento> {
  NumberFormat numberFormat = new NumberFormat("00");
  TimeOfDay timeEntrada = TimeOfDay.now();
  TimeOfDay timeSaida = TimeOfDay.now();
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopoPadrao(
        titulo: "Reserva",
      ),
      body: Column(
        children: [
          ContainerDados(
            titulo: widget.estacionamento.nomeEstacionamento,
            dados: [
              Text(EstacionamentoService()
                  .enderecoCompleto(widget.estacionamento)),
              Text("Telefone: " + widget.estacionamento.telefone),
            ],
          ),
          ContainerDados(
            titulo: "Entrada",
            dados: [
              Row(
                children: [
                  Text("Dia: "),

                  /*
                  DatePicker(
                    selectedDate: date,
                  ),
                  */

                  OutlinedButton(
                    onPressed: () async {
                      final newDate = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 1),
                        builder: (context, child) {
                          return MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(alwaysUse24HourFormat: true),
                            child: child ?? Container(),
                          );
                        },
                      );
                      if (newDate != null) {
                        setState(() {
                          date = newDate;
                        });
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      )),
                    ),
                    child: Text(
                        '${numberFormat.format(date.day).toString()}/${numberFormat.format(date.month).toString()}/${numberFormat.format(date.year).toString()}'),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Horário: "),

                  /*
                  TimePicker(
                    selectedTime: timeEntrada,
                  ),
                  */

                  OutlinedButton(
                    onPressed: () async {
                      final newTime = await showTimePicker(
                        context: context,
                        initialTime: timeEntrada,
                        builder: (context, child) {
                          return MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(alwaysUse24HourFormat: true),
                            child: child ?? Container(),
                          );
                        },
                      );
                      if (newTime != null) {
                        setState(() {
                          timeEntrada = newTime;
                        });
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      )),
                    ),
                    child: Text(
                        '${numberFormat.format(timeEntrada.hour).toString()}:${numberFormat.format(timeEntrada.minute).toString()}'),
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

                  /*
                  TimePicker(
                    selectedTime: timeSaida,
                    onChanged: (TimeOfDay? newTime) => setState(() {
                      timeSaida = newTime!;
                    }),
                  ),
*/
                  OutlinedButton(
                    onPressed: () async {
                      final newTime = await showTimePicker(
                        context: context,
                        initialTime: timeSaida,
                        builder: (context, child) {
                          return MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(alwaysUse24HourFormat: true),
                            child: child ?? Container(),
                          );
                        },
                      );
                      if (newTime != null) {
                        setState(() {
                          timeSaida = newTime;
                        });
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      )),
                    ),
                    child: Text(
                        '${numberFormat.format(timeSaida.hour).toString()}:${numberFormat.format(timeSaida.minute).toString()}'),
                  ),
                ],
              ),
            ],
          ),
          Button(
            rotulo: "Reservar",
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              int? idUsuario = await prefs.getInt('USER_ID');
              var dataReserva = date.year.toString() +
                  "-" +
                  date.month.toString() +
                  "-" +
                  date.day.toString();
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
                idUsuario,
                //widget.estacionamento.valorHora,
              );
              print('---------------------');
              print(reserva.horarioEntrada.toString() +
                  reserva.horarioSaida.toString());
              print('---------------------------------');
              ReservaService()
                  .cadastrarReserva(reserva, widget.estacionamento.valorHora, widget.estacionamento.idEstacionamento);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Pagamento(
                            reserva: reserva,
                          )));
            },
          ),
        ],
      ),
    );
  }
}
