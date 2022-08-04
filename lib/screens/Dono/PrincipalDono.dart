import 'package:estacionamento/screens/Dono/EstacionamentosDono.dart';
import 'package:estacionamento/screens/PerfilUsuario.dart';
import 'package:estacionamento/screens/ReservasMotorista.dart';
import 'package:flutter/material.dart';
import '../../components/ActionButton.dart';
import '../../components/Editor.dart';
import '../../components/ListaEstacionamento.dart';
import '../../http/EstacionamentoService.dart';
import '../../http/FavoritoService.dart';
import '../../models/Estacionamento.dart';
import '../../models/Usuario.dart';

class PrincipalDono extends StatefulWidget {
  final Usuario user;

  PrincipalDono({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<PrincipalDono> createState() => _PrincipalDonoState();
}

class _PrincipalDonoState extends State<PrincipalDono> {
  static const _tamanhoActionButtons = 55.0;
  bool isFavoriteVisible = false;
  static TextEditingController buscaCidade = TextEditingController();
  static TextEditingController buscaRua = TextEditingController();
  var listar;

  @override
  void initState() {
    listar = ListaEstacionamento(buscar('', '', widget.user.idUsuario!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ActionButton(
                  tamanhoBotao: _tamanhoActionButtons,
                  simbolo: Icons.person,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PerfilUsuario(user: widget.user)));
                  },
                ),
                ActionButton(
                  tamanhoBotao: _tamanhoActionButtons,
                  simbolo: Icons.star,
                  corSimbolo: !isFavoriteVisible ? null : Color(0xFF8A67EF),
                  onPressed: () => setState(() {
                    isFavoriteVisible = !isFavoriteVisible;
                  }),
                ),
                ActionButton(
                  tamanhoBotao: _tamanhoActionButtons,
                  simbolo: Icons.manage_search,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ReservasMotorista(user: widget.user)));
                  },
                ),
                ActionButton(
                  tamanhoBotao: _tamanhoActionButtons,
                  simbolo: Icons.car_rental,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EstacionamentosDono(user: widget.user)));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Editor(
              rotulo: 'Informe sua cidade',
              largura: 370.0,
              icone: Icons.search,
              controlador: buscaCidade,
              onSubmitted: (buscaCidade) {
                setState(() {
                  listar = ListaEstacionamento(EstacionamentoService()
                      .listarEstacionamentoBusca(buscaCidade, ''));
                });
              },
            ),
            Editor(
              rotulo: 'Informe o logradouro de destino',
              largura: 370.0,
              icone: Icons.search,
              controlador: buscaRua,
              onSubmitted: (buscaRua) {
                setState(() {
                  listar = ListaEstacionamento(EstacionamentoService()
                      .listarEstacionamentoBusca('', buscaRua));
                });
              },
            ),
            Visibility(
              child: listar,
              visible: !isFavoriteVisible,
            ),
            Visibility(
              child: ListaEstacionamento(FavoritoService()
                  .listarEstacionamentosFavoritados(widget.user.idUsuario!)),
              visible: isFavoriteVisible,
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<Estacionamento>> buscar(
    String buscaCidade, String buscaRua, int idUsuario) {
  var lista;
  if (buscaCidade == "" && buscaRua == "") {
    return lista = EstacionamentoService().listarEstacionamento(idUsuario);
  } else {
    return lista = EstacionamentoService()
        .listarEstacionamentoBusca(buscaCidade, buscaRua);
  }
}
