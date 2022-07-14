 // NÃO MEXA AQUI PELO AMORRRRR
/*
import 'package:flutter/material.dart';
import '../components/ActionButton.dart';
import '../components/Editor.dart';
import '../components/ListaEstacionamento.dart';
import 'PerfilUsuario.dart';

class PrincipalUsuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MenuCima(),
      body: Center(
        child: Column(
          children: [
            Editor(
              rotulo: 'Informe a rua de destino',
              largura: 350.0,
              icone: Icons.search,
            ),
            ListaEstacionamento(),
          ],
        ),
      ),
    );
  }
}

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
    return PreferredSize(
      preferredSize: Size.fromHeight(100.0),
      child: DefaultTabController(
        length: 3,
        child: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: <Widget>[
            Tab(
              child: ActionButton(
                tamanhoBotao: _tamanhoActionButtons,
                simbolo: Icons.person,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PerfilUsuario(),
                    ),
                  );
                },
              ),
            ),
            Tab(
              child: ActionButton(
                tamanhoBotao: _tamanhoActionButtons,
                simbolo: Icons.star,
                onPressed: () {},
              ),
            ),
            Tab(
              child: ActionButton(
                tamanhoBotao: _tamanhoActionButtons,
                simbolo: Icons.manage_search,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
/*
    AppBar(
      automaticallyImplyLeading: false,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ActionButton(
              tamanhoBotao: _tamanhoActionButtons,
              simbolo: Icons.person,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PerfilUsuario(),
                  ),
                );
              },
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
    );*/
  }
}
*/