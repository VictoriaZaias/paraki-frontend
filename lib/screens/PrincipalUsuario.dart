import 'package:estacionamento/screens/PerfilUsuario.dart';
import 'package:flutter/material.dart';
import '../components/ActionButton.dart';
import '../components/Editor.dart';
import '../components/ListaEstacionamento.dart';
import '../http/EstacionamentoService.dart';
import '../models/Estacionamento.dart';
import '../models/Usuario.dart';

class PrincipalUsuario extends StatefulWidget {
  final Usuario? user;
  PrincipalUsuario({this.user});

  @override
  State<PrincipalUsuario> createState() => _PrincipalUsuarioState();
}

class _PrincipalUsuarioState extends State<PrincipalUsuario> {
  static const _tamanhoActionButtons = 55.0;
  bool isFavoriteVisible = false;
  static TextEditingController buscaRua = TextEditingController();
  var listar = ListaEstacionamento(buscar(''));
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ActionButton(
                  tamanhoBotao: _tamanhoActionButtons,
                  simbolo: Icons.person,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PerfilUsuario(user: widget.user!)));
                  },
                ),
                ActionButton(
                  tamanhoBotao: _tamanhoActionButtons,
                  simbolo: Icons.star,
                  onPressed: () {
                    setState(() => isFavoriteVisible = !isFavoriteVisible);
                  },
                ),
                ActionButton(
                  tamanhoBotao: _tamanhoActionButtons,
                  simbolo: Icons.manage_search,
                  onPressed: () {
                      listar = ListaEstacionamento(buscar(buscaRua.text));
                      setState((){});
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
              rotulo: 'Informe a rua de destino',
              largura: 350.0,
              icone: Icons.search,
              controlador: buscaRua,
            ),
            Visibility(
              child: listar,
              visible: !isFavoriteVisible,
            ),
            Visibility(
              child: Text("Lista dos estacionamentos favoritados."),
              visible: isFavoriteVisible,
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<Estacionamento>> buscar(String busca){
  var lista;
  if (busca == ""){
    return lista = estacionamentoService().listarEstacionamento();
  }else{
    return lista = estacionamentoService().listarEstacionamentoBusca(busca);
  }
}
