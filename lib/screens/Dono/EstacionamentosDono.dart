import 'package:estacionamento/screens/Dono/CadastroEstacionamento.dart';
import 'package:flutter/material.dart';
import '../../components/ActionButton.dart';
import '../../components/ListaEstacionamento.dart';
import '../../http/EstacionamentoService.dart';
import '../../http/EstacionamentoService.dart';
import '../../models/Usuario.dart';

class EstacionamentosDono extends StatefulWidget {
  final Usuario user;

  EstacionamentosDono({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<EstacionamentosDono> createState() => _EstacionamentosDonoState();
}

class _EstacionamentosDonoState extends State<EstacionamentosDono> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(95.0),
        child: AppBar(
          centerTitle: true,
          toolbarHeight: 90.0,
          leadingWidth: 90.0,
          leading: ActionButton(
            simbolo: Icons.arrow_back,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Column(
            children: [
              Text(
                "Meus",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 19.0,
                ),
              ),
              Text(
                "estacionamentos",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 19.0,
                ),
              ),
            ],
          ),
          actions: [
            ActionButton(
              simbolo: Icons.add,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CadastroEstacionamento(widget.user.idUsuario!)));
              },
            ),
          ],
        ),
      ),
      body:// SingleChildScrollView(
       // child:
         Column(
          children: [
            ListaEstacionamento(EstacionamentoService()
                .listarEstacionamentosDono(widget.user.idUsuario!)),
          ],
        ),
     // ),
    );
  }
}
