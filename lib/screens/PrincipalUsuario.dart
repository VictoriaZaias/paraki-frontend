import 'package:estacionamento/http/FavoritoService.dart';
import 'package:estacionamento/screens/PerfilUsuario.dart';
import 'package:flutter/material.dart';
import '../components/ActionButton.dart';
import '../components/Editor.dart';
import '../components/ListaEstacionamentos.dart';
import '../components/Mapa.dart';
import '../http/EstacionamentoService.dart';
import '../models/Estacionamento.dart';
import '../models/Usuario.dart';
import 'ReservasMotorista.dart';

class PrincipalUsuario extends StatefulWidget {
  final Usuario user;

  PrincipalUsuario({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<PrincipalUsuario> createState() => _PrincipalUsuarioState();
}

class _PrincipalUsuarioState extends State<PrincipalUsuario> {
  late TextEditingController? buscaCidade;
  late TextEditingController? buscaRua;
  var listar;
  var listarFavoritos;

  @override
  void initState() {
    super.initState();
    buscaCidade = TextEditingController();
    buscaRua = TextEditingController();
    listar = ListaEstacionamento(buscar('', '', widget.user.idUsuario!));
    listarFavoritos =
        ListaEstacionamento(buscarFavoritos('', '', widget.user.idUsuario!));
  }

  @override
  void dispose() {
    buscaCidade!.dispose();
    buscaRua!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: IconButton(
                onPressed: () async {
                  filtroDialog(context);
                },
                icon: Icon(
                  Icons.filter_list,
                  color: Color(0xFFEDE4E2),
                ),
              ),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                child: Icon(
                  Icons.manage_search,
                  color: Color(0xFFEDE4E2),
                ),
              ),
              Tab(
                child: Icon(
                  Icons.star,
                  color: Color(0xFFEDE4E2),
                ),
              ),
              Tab(
                child: Icon(
                  Icons.location_on,
                  color: Color(0xFFEDE4E2),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Column(
              children: [
                listar,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ActionButton(
                      simbolo: Icons.refresh,
                      onPressed: () {
                        setState(() {
                          listar = ListaEstacionamento(
                              buscar('', '', widget.user.idUsuario!));
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                listarFavoritos,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ActionButton(
                      simbolo: Icons.refresh,
                      onPressed: () {
                        setState(() {
                          listarFavoritos = ListaEstacionamento(
                              buscarFavoritos('', '', widget.user.idUsuario!));
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            Center(
              child: Mapa(),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF8A67EF),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Color(0xFFEDE4E2),
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: const Text('Perfil'),
                iconColor: Colors.black,
                textColor: Colors.black,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PerfilUsuario(user: widget.user),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.calendar_month),
                title: const Text('Minhas reservas'),
                iconColor: Colors.black,
                textColor: Colors.black,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ReservasMotorista(user: widget.user),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future filtroDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
          primary: Color(0xFFB497F2),
        )),
        child: AlertDialog(
          title: Text("Filtro"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                decoration: InputDecoration(hintText: "Informe a cidade"),
                controller: buscaCidade,
              ),
              SizedBox(height: 15),
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Informe a rua",
                ),
                controller: buscaRua,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  listar = ListaEstacionamento(EstacionamentoService()
                      .listarEstacionamentoBusca(buscaCidade!.text,
                          buscaRua!.text, widget.user.idUsuario!));
                });
                Navigator.of(context).pop();
              },
              child: Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<Estacionamento>> buscar(
    String buscaCidade, String buscaRua, int idUsuario) {
  var lista;
  if (buscaCidade == "" && buscaRua == "") {
    return lista = EstacionamentoService().listarEstacionamento(idUsuario);
  } else {
    return lista = EstacionamentoService()
        .listarEstacionamentoBusca(buscaCidade, buscaRua, idUsuario);
  }
}

Future<List<Estacionamento>> buscarFavoritos(
    String buscaCidade, String buscaRua, int idUsuario) {
  var lista;
  if (buscaCidade == "" && buscaRua == "") {
    return lista =
        FavoritoService().listarEstacionamentosFavoritados(idUsuario);
  } else {
    return lista =
        FavoritoService().listarEstacionamentosFavoritados(idUsuario);
  }
}
