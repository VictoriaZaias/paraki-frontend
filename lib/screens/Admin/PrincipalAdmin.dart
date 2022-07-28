import 'package:estacionamento/components/ContainerDados.dart';
import 'package:flutter/material.dart';
import '../../components/Button.dart';
import 'AdminCadastro.dart';
import 'AdminAlterar.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFB497F2), width: 1.5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
                          child: Text(
                            "Usuário",
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Button(
                      rotulo: "Inserir",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminCadastro()));
                      },
                    ),
                    Button(
                      rotulo: "Alterar",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminProcura()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
