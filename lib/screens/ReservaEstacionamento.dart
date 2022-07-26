import 'package:estacionamento/components/DropdownSelect.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/ActionButton.dart';
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
  TimeOfDay time = TimeOfDay.now();
  DateTime date = DateTime.now();
  NumberFormat numberFormat = new NumberFormat("00");
  int? horas_reserva = 0;
  static TextEditingController dataEntrada = TextEditingController();
  static TextEditingController horarioEntrada = TextEditingController();
  static TextEditingController dataSaida = TextEditingController();
  static TextEditingController horarioSaida = TextEditingController();

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
              Text(estacionamentoService()
                  .enderecoCompleto(widget.estacionamento)),
              Text("Telefone: " + widget.estacionamento.telefone),
            ],
          ),
          ContainerDados(
            titulo: "Entrada",
            dados: _dataEntradaSaida(),
          ),
          ContainerDados(
            titulo: "Saída",
            dados: _dataEntradaSaida(),
          ),
          Button(
            rotulo: "Reservar",
            onPressed: () {
              
            },
          ),
        ],
      ),
    );
  }

  int _calculoReserva() {
    return horas_reserva! * widget.estacionamento.valorHora;
  }

  List<Widget> _dataEntradaSaida() {
    return [
      Row(
        children: [
          Text("Dia: "),
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
          OutlinedButton(
            onPressed: () async {
              final newTime = await showTimePicker(
                context: context,
                initialTime: time,
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
                  time = newTime;
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
                '${numberFormat.format(time.hour).toString()}:${numberFormat.format(time.minute).toString()}'),
          ),
        ],
      ),
    ];
  }
}
