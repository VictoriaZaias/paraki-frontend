import 'package:estacionamento/models/Usuario.dart';
import 'package:flutter/material.dart';
import '../components/ActionButton.dart';
import '../components/Editor.dart';
import '../components/ListaEstacionamento.dart';
import 'PerfilUsuario.dart';

class PrincipalUsuario extends StatefulWidget {
  final Usuario? user;
  PrincipalUsuario({this.user});

  @override
  State<PrincipalUsuario> createState() => _PrincipalUsuarioState();
}

class _PrincipalUsuarioState extends State<PrincipalUsuario> {
  static const _tamanhoActionButtons = 55.0;
  bool isFavoriteVisible = false;

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
                  onPressed: () {},
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
            ),
            Visibility(
              child: ListaEstacionamento(),
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
