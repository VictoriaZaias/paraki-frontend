import 'package:estacionamento/components/ActionButton.dart';
import 'package:estacionamento/models/Usuario.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';
import 'Login.dart';

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
          dadosUsuario("CPF", user.cpf, Icons.edit, null),
          dadosUsuario("Senha", user.senha, Icons.edit, null),
          dadosUsuario(
              "Modelo do(s) carro(s)", user.modeloCarro, Icons.edit, null),
          dadosUsuario(
              "Sair do app", null, Icons.logout_rounded, null),
        ],
      ),
    );
  }

  Container dadosUsuario(
      String titulo, String? dado, IconData? icone, Function()? acao) {
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
        title: Text(titulo),
        subtitle: dado != null ? Text(dado) : null,
        trailing: icone != null
            ? IconButton(
                onPressed: () {
                  acao;
                },
                icon: Icon(
                  icone,
                  color: Color(0xFFEDE4E2),
                ),
              )
            : null,
      ),
    );
  }

  signOut(BuildContext context) async {
    //await signOut(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }
}
