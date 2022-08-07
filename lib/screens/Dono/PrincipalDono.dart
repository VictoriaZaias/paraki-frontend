import 'package:estacionamento/screens/Dono/EstacionamentosDono.dart';
import 'package:estacionamento/screens/PerfilUsuario.dart';
import 'package:estacionamento/screens/ReservasMotorista.dart';
import 'package:flutter/material.dart';
import '../../components/ActionButton.dart';
import '../../components/Editor.dart';
import '../../components/ListaEstacionamentos.dart';
import '../../http/EstacionamentoService.dart';
import '../../http/FavoritoService.dart';
import '../../models/Estacionamento.dart';
import '../../models/Usuario.dart';

class PrincipalDono extends StatefulWidget {
  final Usuario user;

  PrincipalDono({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<PrincipalDono> createState() => _PrincipalDonoState();
}

class _PrincipalDonoState extends State<PrincipalDono> {
  late TextEditingController? buscaCidade;
  late TextEditingController? buscaRua;
  var listar;

  @override
  void initState() {
    super.initState();
    buscaCidade = TextEditingController();
    buscaRua = TextEditingController();
    listar = ListaEstacionamento(buscar('', '', widget.user.idUsuario!));
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
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
          children: [
            Column(
              children: [
                listar,
              ],
            ),
            Column(
              children: [
                ListaEstacionamento(FavoritoService()
                    .listarEstacionamentosFavoritados(widget.user.idUsuario!)),
              ],
            ),
            Center(
              child: Text("Mapa. vem aí?"),
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
                child: Text('Menu dono de estacionamento'),
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
              ListTile(
                leading: Icon(Icons.car_crash_outlined),
                title: const Text('Meus estacionamentos'),
                iconColor: Colors.black,
                textColor: Colors.black,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EstacionamentosDono(user: widget.user),
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
