import 'package:flutter/material.dart';
import '../../components/CardEsqueleto.dart';
import '../../components/CardEstacionamento.dart';
import '../../components/ListaEstacionamentos.dart';
import '../../components/Mapa.dart';
import '../../http/EstacionamentoService.dart';
import '../../http/FavoritoService.dart';
import '../../models/Estacionamento.dart';
import '../../models/Usuario.dart';
import '../PerfilUsuario.dart';
import '../ReservasMotorista.dart';
import 'EstacionamentosDono.dart';

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
  List<Estacionamento> listaEstacionamentos = [];
  List<Estacionamento> listaEstacionamentosFavoritados = [];
  late TextEditingController? buscaCidade;
  late TextEditingController? buscaRua;
  var listar;

  @override
  void initState() {
    super.initState();
    buscaCidade = TextEditingController();
    buscaRua = TextEditingController();
    _fetchData();
  }

  Future _fetchData() async {
    List<Estacionamento> e = await EstacionamentoService()
        .listarEstacionamento(widget.user.idUsuario!);
    List<Estacionamento> f = await FavoritoService()
        .listarEstacionamentosFavoritados(widget.user.idUsuario!);
    setState(() {
      listaEstacionamentos = e;
      listaEstacionamentosFavoritados = f;
    });
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
                Expanded(
                  child:
                      listaEstacionamentos.isEmpty || listaEstacionamentos == null
                          ? ListView.builder(
                              itemCount: 7,
                              itemBuilder: (context, index) => CardEsqueleto(
                                icone: Image.asset(
                                  'assets/images/carro.png',
                                  scale: 3,
                                ),
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: _fetchData,
                              child: ListView.builder(
                                physics: AlwaysScrollableScrollPhysics(),
                                itemCount: listaEstacionamentos.length,
                                itemBuilder: (context, index) {
                                  final Estacionamento estacionamento =
                                      listaEstacionamentos[index];
                                  return CardEstacionamento(
                                    estacionamento: estacionamento,
                                  );
                                },
                              ),
                            ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child:
                      listaEstacionamentosFavoritados.isEmpty || listaEstacionamentosFavoritados == null
                          ? ListView.builder(
                              itemCount: 7,
                              itemBuilder: (context, index) => CardEsqueleto(
                                icone: Image.asset(
                                  'assets/images/carro.png',
                                  scale: 3,
                                ),
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: _fetchData,
                              child: ListView.builder(
                                physics: AlwaysScrollableScrollPhysics(),
                                itemCount: listaEstacionamentosFavoritados.length,
                                itemBuilder: (context, index) {
                                  final Estacionamento estacionamentoFavoritado =
                                      listaEstacionamentosFavoritados[index];
                                  return CardEstacionamento(
                                    estacionamento: estacionamentoFavoritado,
                                  );
                                },
                              ),
                            ),
                ),
              ],
            ),
            /*
            Column(
              children: [
                ListaEstacionamento(FavoritoService()
                    .listarEstacionamentosFavoritados(widget.user.idUsuario!)),
              ],
            ),*/
            Center(
              child: Mapa(latitude: -25.4415572, longitude: -54.4026853),
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
/*
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
*/