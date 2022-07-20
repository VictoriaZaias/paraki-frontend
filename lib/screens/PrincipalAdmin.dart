import 'package:flutter/material.dart';
import '../components/Button.dart';
import 'AdminCadastro.dart';

class PrincipalAdmin extends StatelessWidget {
  const PrincipalAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          centerTitle: true,
          toolbarHeight: 100.0,
          automaticallyImplyLeading: false,
          title: Text(
            "Admin",
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text(
                "Usuário",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Button(
                rotulo: "Inserir",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminCadastro()));
                },
              ),
              Button(
                rotulo: "Alterar/Inativar",
                onPressed: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
