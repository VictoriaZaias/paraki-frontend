import 'package:estacionamento/components/ActionButton.dart';
import 'package:estacionamento/models/Usuario.dart';
import 'package:flutter/material.dart';

class PerfilUsuario extends StatelessWidget {
  final Usuario user;
  PerfilUsuario({required this.user});

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
          Container(
            decoration: BoxDecoration(
              //color: Color(0xFFEDE4E2),
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFB497F2),
                  width: 1.5,
                ),
              ),
            ),
            child: ListTile(
              title: Text("CPF"),
              subtitle: Text(user.cpf),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              //color: Color(0xFFEDE4E2),
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFB497F2),
                  width: 1.5,
                ),
              ),
            ),
            child: ListTile(
              title: Text("Senha"),
              subtitle: Text(user.senha),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              //color: Color(0xFFEDE4E2),
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFB497F2),
                  width: 1.5,
                ),
              ),
            ),
            child: ListTile(
              title: Text("Modelo do(s) carro(s)"),
              subtitle: Text(user.modeloCarro),
            ),
          ),
        ],
      ),
    );
  }
}
