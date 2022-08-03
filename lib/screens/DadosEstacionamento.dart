import 'dart:convert';
import 'package:estacionamento/http/HorarioFuncionamentoService.dart';
import 'package:estacionamento/models/Caracteristica.dart';
import 'package:estacionamento/models/HorarioFuncionamento.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/ActionButton.dart';
import '../components/Button.dart';
import '../components/ContainerDados.dart';
import '../components/ListaCaracteristicas.dart';
import '../components/ListaHorariosFuncionamento.dart';
import '../http/CaracteristicaService.dart';
import '../http/EstacionamentoService.dart';
import '../http/FavoritoService.dart';
import '../models/Estacionamento.dart';
import '../models/Favorito.dart';
import 'ReservaEstacionamento.dart';

class DadosEstacionamento extends StatefulWidget {
  final Estacionamento estacionamento;

  DadosEstacionamento({
    Key? key,
    required this.estacionamento,
  }) : super(key: key);

  @override
  State<DadosEstacionamento> createState() => _DadosEstacionamentoState();
}

class _DadosEstacionamentoState extends State<DadosEstacionamento> {
  bool isFavorited = false;

  void _fetchData() async {
    List<Caracteristica> listaCaracteristicas = await CaracteristicaService()
        .listarCaracteristicas(widget.estacionamento.idEstacionamento!);
    List<HorarioFuncionamento> listaHorarios =
        await HorarioFuncionamentoService()
            .listarHorarios(widget.estacionamento.idEstacionamento!);
  }

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
              corSimbolo: isFavorited ? Color(0xFF8A67EF) : null,
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                int? idUsuario = await prefs.getInt('USER_ID');
                Favorito favorito = Favorito(
                  idUsuario,
                  widget.estacionamento.idEstacionamento,
                );
                FavoritoService().cadastrarFavorito(favorito);
                isFavorited = !isFavorited;
              },
              // sinalizar que o estacionamento foi favoritado com sucesso
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ContainerDados(
              titulo: widget.estacionamento.nomeEstacionamento,
              dados: _dadosGerais(),
            ),
            ContainerDados(
              titulo: "Vagas",
              dados: _dadosVagas(),
            ),
            ContainerDados(
              titulo: "Preços",
              dados: _dadosPrecos(),
            ),
            ContainerDados(
              titulo: "Horario de funcionamento",
              dados: [
                ListaHorariosFuncionamento(
                    widget.estacionamento.idEstacionamento!),
              ],
            ),
            ContainerDados(
              titulo: "Caracteristicas",
              dados: [
                SizedBox(
                  height: 90.0,
                  child: ListaCaracteristicas(CaracteristicaService()
                      .listarCaracteristicas(
                          widget.estacionamento.idEstacionamento!)),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
              child: Button(
                rotulo: "Reservar",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReservaEstacionamento(
                            estacionamento: widget.estacionamento)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _dadosGerais() {
    return [
      Text(EstacionamentoService().enderecoCompleto(widget.estacionamento)),
      Text("Telefone: " + widget.estacionamento.telefone),
    ];
  }

  List<Widget> _dadosVagas() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Total de vagas"),
          Text(widget.estacionamento.qtdTotalVagas.toString() + " vagas"),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Vagas disponíveis"),
          Text(widget.estacionamento.qtdVagasDisponiveis.toString() + " vagas"),
        ],
      ),
    ];
  }

  List<Widget> _dadosPrecos() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("1 hora"),
          Text("R\$ " + widget.estacionamento.valorHora.toString()),
        ],
      ),
    ];
  }
}
