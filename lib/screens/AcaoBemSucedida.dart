import 'package:estacionamento/components/Button.dart';
import 'package:estacionamento/screens/Dono/EstacionamentosDono.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Usuario.dart';

class AcaoBemSucedida extends StatefulWidget {
  final String mensagem;

  const AcaoBemSucedida(
    this.mensagem, {
    Key? key,
  }) : super(key: key);

  @override
  State<AcaoBemSucedida> createState() => _AcaoBemSucedidaState();
}

class _AcaoBemSucedidaState extends State<AcaoBemSucedida> {
  late SharedPreferences logindata;
  Usuario? usuario;

  @override
  void initState() {
    super.initState();
    pegaUsuario();
  }

  void pegaUsuario() async {
    logindata = await SharedPreferences.getInstance();
    usuario = Usuario(
      logindata.getString('username')!,
      logindata.getString('cpf')!,
      logindata.getString('tipo_user')!,
      logindata.getString('modelo_carro')!,
      logindata.getString('senha_user')!,
      idUsuario: logindata.getInt('id_user')!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.mensagem,
              style: TextStyle(fontSize: 36.0),
              textAlign: TextAlign.center,
            ),
            Image.asset(
              'assets/images/carro.png',
              scale: 1.4,
            ),
            Button(
              rotulo: "Voltar",
              altura: 40.0,
              onPressed: () {
                if (widget.mensagem ==
                    "Estacionamento cadastrado com sucesso!") {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EstacionamentosDono(user: usuario!),
                    ),
                  );
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
