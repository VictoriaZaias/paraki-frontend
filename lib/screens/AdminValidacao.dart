import 'package:flutter/material.dart';
import '../components/ActionButton.dart';
import '../components/Button.dart';
import 'Agradecimento.dart';

class AdminValidacao extends StatefulWidget {
  const AdminValidacao({Key? key}) : super(key: key);

  @override
  State<AdminValidacao> createState() => _AdminValidacaoState();
}

class _AdminValidacaoState extends State<AdminValidacao> {
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
              Button(
                rotulo: _textoBotaoValidar,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Agradecimento("validado")));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
