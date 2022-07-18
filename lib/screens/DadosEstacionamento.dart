import 'package:flutter/material.dart';

import '../components/ActionButton.dart';

class DadosEstacionamento extends StatelessWidget {
  const DadosEstacionamento({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(95.0),
        child: AppBar(
          toolbarHeight: 90.0,
          leadingWidth: 90.0,
          leading: ActionButton(
            simbolo: Icons.arrow_back,
            onPressed: () {
              Navigator.pop(context);
            },
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
              title: Text("Estacionamento LabIoT"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Av. Tancredo Neves, 6731 - Jardim Itaipu"),
                  Text("Foz do Iguaçu - PR, 85867-900, Brasil"),
                  Text("Fone: +55 44 ****-****"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
