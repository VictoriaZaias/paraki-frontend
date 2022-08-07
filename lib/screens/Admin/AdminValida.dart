import 'package:estacionamento/components/ListaEstacionamentos.dart';
import 'package:estacionamento/http/EstacionamentoService.dart';
import 'package:flutter/material.dart';

import '../../components/ActionButton.dart';
import '../../components/Button.dart';
import '../AcaoBemSucedida.dart';

class AdminValida extends StatefulWidget {
  const AdminValida({Key? key}) : super(key: key);

  @override
  State<AdminValida> createState() => _AdminValidaState();
}

class _AdminValidaState extends State<AdminValida> {
  static const _textoBotaoValidar = 'Validar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          toolbarHeight: 90.0,
          leadingWidth: 90.0,
          leading: ActionButton(
            simbolo: Icons.arrow_back,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            "Validação",
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //ListaEstacionamento(EstacionamentoService().listarEstacionamentoValidacao()),
              Button(
                rotulo: _textoBotaoValidar,
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AcaoBemSucedida("Motorista validado com sucesso!")));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
