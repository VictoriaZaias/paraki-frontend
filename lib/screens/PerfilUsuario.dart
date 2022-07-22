import 'package:estacionamento/components/ActionButton.dart';
import 'package:estacionamento/models/Usuario.dart';
import 'package:flutter/material.dart';

class PerfilUsuario extends StatelessWidget {
  final Usuario user;
  PerfilUsuario({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(210.0),
        child: AppBar(
          toolbarHeight: 90.0,
          leadingWidth: 90.0,
          leading: ActionButton(
            simbolo: Icons.arrow_back,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          flexibleSpace: PreferredSize(
            preferredSize: Size.fromHeight(210.0),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ActionButton(
                    tamanhoBotao: 120.0,
                    simbolo: Icons.person,
                    tamanhoSimbolo: 75.0,
                    onPressed: null,
                  ),
                  Text(
                    user.nomeUsuario,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          dadosUsuario("CPF", user.cpf, Icons.edit),
          dadosUsuario("Senha", user.senha, Icons.edit),
          dadosUsuario("Modelo do(s) carro(s)", user.modeloCarro, Icons.edit),
          dadosUsuario("Sair do app", null, null),
        ],
      ),
    );
  }

  Container dadosUsuario(String titulo, String? dado, IconData? icone) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFB497F2),
            width: 1.5,
          ),
        ),
      ),
      child: ListTile(
        textColor: Color(0xFFEDE4E2),
        title: Text(titulo),
        subtitle: dado != null ? Text(dado) : null,
        trailing: icone != null
            ? IconButton(
                onPressed: () {},
                icon: Icon(
                  icone,
                ),
              )
            : null,
      ),
    );
  }
}
