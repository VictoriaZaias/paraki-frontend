import 'package:estacionamento/components/ActionButton.dart';
import 'package:flutter/material.dart';

import 'PrincipalUsuario.dart';

class PerfilUsuario extends StatelessWidget {
  const PerfilUsuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90.0,
        leadingWidth: 90.0,
        leading: ActionButton(
          simbolo: Icons.arrow_back,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(200.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ActionButton(
                tamanhoBotao: 130.0,
                simbolo: Icons.person,
                tamanhoSimbolo: 80.0,
                onPressed: null,
              ),
              Text("Victória Caroline Souza Zaias"),
            ],
          ),
        ),
      ),
    );
  }
}
