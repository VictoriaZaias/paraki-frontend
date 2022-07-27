import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/ActionButton.dart';
import '../components/Button.dart';
import '../components/ContainerDados.dart';
import '../components/ListaHorariosFuncionamento.dart';
import '../http/EstacionamentoService.dart';
import '../http/FavoritoService.dart';
import '../models/Estacionamento.dart';
import '../models/Favorito.dart';
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
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                int? idUsuario = await prefs.getInt('USER_ID');
                Favorito favorito = Favorito(
                  idUsuario,
                  estacionamento.idEstacionamento,
                );
                FavoritoService().cadastrarFavorito(favorito);
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
              titulo: estacionamento.nomeEstacionamento,
              dados: _dadosGerais(),
            ),
            ContainerDados(
              titulo: "Vagas",
              dados: _dadosVagas(),
            ),
            /*
            SizedBox(
              child: ListaHorariosFuncionamento(estacionamento.idEstacionamento)),
            */
            ContainerDados(
              titulo: "Horario de funcionamento",
              dados: _dadosHorarios(estacionamento.idEstacionamento),
            ),
            ContainerDados(
              titulo: "Preços",
              dados: _dadosPrecos(),
            ),
            /*
            SizedBox(
              height: 50.0 * 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListaCaracteristicas(CaracteristicaService()
                      .listarCaracteristicas(estacionamento.idEstacionamento)),
                ],
              ),
            ),
            */
            /*
            ContainerDados(
              titulo: "Características",
              dados: ListaCaracteristicas(CaracteristicaService()
                  .listarCaracteristicas(estacionamento.idEstacionamento)),
              //_dadosCaracteristicas(),
            ),*/
            Button(
              rotulo: "Reservar",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReservaEstacionamento(
                          estacionamento: estacionamento)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _dadosGerais() {
    return [
      Text(EstacionamentoService().enderecoCompleto(estacionamento)),
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

  List<Widget> _dadosHorarios(int idEstacionamento) {
    List<Widget> h = [
      FractionallySizedBox(
        widthFactor: 1.0,
        heightFactor: 0.5,
        child: ListaHorariosFuncionamento(idEstacionamento),
      ),
    ];
    return h;
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
/*
  List<Widget> _dadosCaracteristicas() {
    List<Widget> c = [];
    estacionamento.caracteristicas.forEach((element) {
      c.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(element.caracteristica),
          ],
        ),
      );
    });
    return c;
  }
  */
}
