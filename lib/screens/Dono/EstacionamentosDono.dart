import 'package:estacionamento/components/CardDono.dart';
import 'package:estacionamento/screens/Dono/CadastroEstacionamento.dart';
import 'package:flutter/material.dart';
import '../../components/ActionButton.dart';
import '../../components/CardEsqueleto.dart';
import '../../components/CenteredMessage.dart';
import '../../components/ListaEstacionamentos.dart';
import '../../http/EstacionamentoService.dart';
import '../../http/EstacionamentoService.dart';
import '../../models/Estacionamento.dart';
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
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Estacionamento>>(
              future: EstacionamentoService()
                  .listarEstacionamentosDono(widget.user.idUsuario!),
              builder: (context, AsyncSnapshot<List<Estacionamento>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    break;
                  case ConnectionState.waiting:
                    return ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) => CardEsqueleto(
                        icone: Image.asset(
                          'assets/images/carro.png',
                          scale: 3,
                        ),
                      ),
                    );
                  case ConnectionState.active:
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      final List<Estacionamento> estacionamentos =
                          snapshot.data ?? [];
                      if (estacionamentos.isNotEmpty) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final Estacionamento estacionamento =
                                estacionamentos[index];
                            return CardDono(
                              estacionamento: estacionamento,
                            );
                          },
                          itemCount: estacionamentos.length,
                        );
                      }
                    }
                    return CenteredMessage(
                      'Nenhum estacionamento encontrado',
                      icon: Icons.block,
                    );
                }
                return CenteredMessage('Unknown error');
              },
            ),
          ),
        ],
      ),
    );
  }
}
