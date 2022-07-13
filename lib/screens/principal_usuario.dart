import 'package:estacionamento/http/estacionamentoService.dart';
import 'package:estacionamento/models/estacionamento.dart';
import 'package:flutter/material.dart';
import '../components/action_button.dart';
import '../components/card_estacionamento.dart';
import '../components/centered_message.dart';
import '../components/editor.dart';
import '../components/progress.dart';

class PrincipalUsuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MenuCima(),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 400.0,
              //height: 90.0,
              child: Editor(
                rotulo: 'Informe a rua de destino',
                icone: Icons.search,
                //comprimento: 350.0,
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Estacionamento>>(
                future: listarEstacionamento(),
                builder:
                    (context, AsyncSnapshot<List<Estacionamento>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      break;
                    case ConnectionState.waiting:
                      return Progress();
                      break;
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
                              return CardEstacionamento(
                                nomeEstacionamento:
                                    estacionamento.nomeEstacionamento,
                                quantidadeTotalVagas: estacionamento
                                    .quantidadeTotalVagas
                                    .toString(),
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
                      break;
                  }
                  return CenteredMessage('Unknown error');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*
class PrincipalUsuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MenuCima(),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 400.0,
              //height: 90.0,
              child: Editor(
                rotulo: 'Informe a rua de destino',
                icone: Icons.search,
                //comprimento: 350.0,
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Estacionamento>>(
                future: listarEstacionamento(),
                builder: (context, snapshot) {
                  final List<Estacionamento> estacionamentos = snapshot.data ?? [];
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Estacionamento estacionamento =
                          estacionamentos[index];
                      return CardEstacionamento(
                        nomeEstacionamento: estacionamento.nomeEstacionamento,
                        quantidadeTotalVagas:
                            estacionamento.quantidadeTotalVagas.toString(),
                      );
                    },
                    itemCount: estacionamentos.length,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
*/

class MenuCima extends StatefulWidget implements PreferredSizeWidget {
  const MenuCima({Key? key}) : super(key: key);

  @override
  State<MenuCima> createState() => _MenuCimaState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    return new Size.fromHeight(80.0);
  }
}

class _MenuCimaState extends State<MenuCima> {
  static const _tamanhoActionButtons = 55.0;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ActionButton(
              tamanhoBotao: _tamanhoActionButtons,
              simbolo: Icons.person,
              onPressed: () {},
            ),
            ActionButton(
              tamanhoBotao: _tamanhoActionButtons,
              simbolo: Icons.star,
              onPressed: () {},
            ),
            ActionButton(
              tamanhoBotao: _tamanhoActionButtons,
              simbolo: Icons.manage_search,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
