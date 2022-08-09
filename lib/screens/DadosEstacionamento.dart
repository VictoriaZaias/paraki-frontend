import 'dart:convert';
import 'package:estacionamento/http/HorarioFuncionamentoService.dart';
import 'package:estacionamento/models/Caracteristica.dart';
import 'package:estacionamento/models/HorarioFuncionamento.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletons/skeletons.dart';
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
import 'CadastroReserva.dart';

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
  List<Caracteristica> listaCaracteristicas = [];
  List<HorarioFuncionamento> listaHorarios = [];
  bool? isFavoritado;

  @override
  void initState() {
    super.initState();
    isFavoritado = widget.estacionamento.isFavoritado!;
    _fetchData();
  }

  void _fetchData() async {
    List<Caracteristica> c = await CaracteristicaService()
        .listarCaracteristicas(widget.estacionamento.idEstacionamento!);
    List<HorarioFuncionamento> h = await HorarioFuncionamentoService()
        .listarHorarios(widget.estacionamento.idEstacionamento!);
    setState(() {
      listaCaracteristicas = c;
      listaHorarios = h;
    });
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
              corSimbolo: isFavoritado! ? Color(0xFF8A67EF) : null,
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                int? idUsuario = await prefs.getInt('USER_ID');
                Favorito favorito = Favorito(
                  idUsuario,
                  widget.estacionamento.idEstacionamento,
                );
                if (isFavoritado!)
                  FavoritoService().excluirFavorito(favorito);
                else
                  FavoritoService().cadastrarFavorito(favorito);
                setState(() {
                  isFavoritado = !isFavoritado!;
                });
              },
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
                SizedBox(
                  height: 68,
                  child: listaHorarios.isEmpty || listaHorarios == null
                      ? ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) =>
                              horariosEsqueleto(context),
                        )
                      : ListView.builder(
                          //physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(bottom: 10),
                          itemCount: listaHorarios.length,
                          itemBuilder: (context, index) {
                            final horarioFuncionamento = listaHorarios[index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(horarioFuncionamento.diaSemana + ":"),
                                Text(horarioFuncionamento.horarioInicio +
                                    " - " +
                                    horarioFuncionamento.horarioFim),
                              ],
                            );
                          },
                        ),
                ),
              ],
            ),
            ContainerDados(
              titulo: "Caracteristicas",
              dados: [
                SizedBox(
                  height: 23.0 * listaCaracteristicas.length,
                  child: listaCaracteristicas.isEmpty ||
                          listaCaracteristicas == null
                      ? ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) =>
                              paragrafoEsqueleto(context),
                        )
                      : ListView.builder(
                          //physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(bottom: 10),
                          itemCount: listaCaracteristicas.length,
                          itemBuilder: (context, index) {
                            final caracteristica = listaCaracteristicas[index];
                            return Row(
                              children: [
                                Text(caracteristica.caracteristica),
                              ],
                            );
                          },
                        ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
              child: Button(
                rotulo: "Reserve",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CadastroReserva(
                          estacionamento: widget.estacionamento),
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

  List<Widget> _dadosGerais() {
    return [
      Text(EstacionamentoService().enderecoCompleto(widget.estacionamento)),
      Text("Telefone: " + widget.estacionamento.telefone!),
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

  Widget horariosEsqueleto(BuildContext context) {
    return SkeletonItem(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          randomLength: true,
                          height: 14,
                          borderRadius: BorderRadius.circular(8),
                          minLength: MediaQuery.of(context).size.width / 5,
                          maxLength: MediaQuery.of(context).size.width / 3,
                        ),
                      ),
                      Row(
                        children: [
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              width: 55,
                              height: 14,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          SizedBox(width: 8),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              width: 55,
                              height: 14,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget paragrafoEsqueleto(BuildContext context) {
    return SkeletonItem(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SkeletonParagraph(
                  style: SkeletonParagraphStyle(
                    lines: 1,
                    padding: EdgeInsets.symmetric(vertical: 4),
                    spacing: 6,
                    lineStyle: SkeletonLineStyle(
                      randomLength: true,
                      height: 14,
                      borderRadius: BorderRadius.circular(8),
                      minLength: MediaQuery.of(context).size.width / 3,
                      maxLength: MediaQuery.of(context).size.width / 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
