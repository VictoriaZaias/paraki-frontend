import 'dart:convert';

import 'package:estacionamento/components/ListaHorarios.dart';
import 'package:estacionamento/http/HorarioFuncionamentoService.dart';
import 'package:estacionamento/models/HorarioFuncionamento.dart';
import 'package:flutter/material.dart';
import '../components/ActionButton.dart';
import '../components/Button.dart';
import '../components/ContainerDados.dart';
import '../http/EstacionamentoService.dart';
import '../models/Estacionamento.dart';
import 'ReservaEstacionamento.dart';

class DadosEstacionamento extends StatelessWidget {
  final Estacionamento estacionamento;

  DadosEstacionamento({
    Key? key,
    required this.estacionamento,
  }) : super(key: key);

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
          title: Text(
            "Estacionamento",
            style: TextStyle(
              fontWeight: FontWeight.w300,
            ),
          ),
          actions: [
            ActionButton(
              simbolo: Icons.star,
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          ContainerDados(
            titulo: estacionamento.nomeEstacionamento,
            dados: _dadosGerais(),
          ),
          ContainerDados(
            titulo: "Vagas",
            dados: _dadosVagas(),
          ), 
          ContainerDados (
            titulo: "Horario de funcionamento",
            dados: _dadosHorarios(),
          ),
          ContainerDados(
            titulo: "Preços",
            dados: _dadosPrecos(),
          ),
          ContainerDados(
            titulo: "Características",
            dados: _dadosCaracteristicas(),
          ),
          Button(
            rotulo: "Reservar",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ReservaEstacionamento(estacionamento: estacionamento)),
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _dadosGerais() {
    return [
      Text(estacionamentoService().enderecoCompleto(estacionamento)),
      Text("Telefone: " + estacionamento.telefone),
    ];
  }

  List<Widget> _dadosVagas() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Total de vagas"),
          Text(estacionamento.qtdTotalVagas.toString() + " vagas"),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Vagas disponíveis"),
          Text(estacionamento.qtdVagasDisponiveis.toString() + " vagas"),
        ],
      ),
    ];
  }

  List<Widget> _dadosHorarios() {
    List<Widget> a = [];
    estacionamento.horarios.forEach((element) {
      a.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(element.diaSemana+": "+element.horarioInicio+" - "+element.horarioFim),
          ],
        ),
      );
    });
    return a;
  }

  List<Widget> _dadosPrecos() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("1 hora"),
          Text("R\$ " + estacionamento.valorHora.toString()),
        ],
      ),
    ];
  }

  List<Widget> _dadosCaracteristicas() {
    return [];
  }
}
