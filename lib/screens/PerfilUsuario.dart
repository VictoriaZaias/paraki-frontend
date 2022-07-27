import 'package:estacionamento/components/ActionButton.dart';
import 'package:estacionamento/models/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';

class PerfilUsuario extends StatefulWidget {
  final Usuario user;

  PerfilUsuario({
    required this.user,
  });

  @override
  State<PerfilUsuario> createState() => _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuario> {
  //
  late SharedPreferences logindata;
  late String username;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(210.0),
        child: AppBar(
          toolbarHeight: 90.0,
          leadingWidth: 90.0,
          leading: ActionButton(
            simbolo: Icons.arrow_back,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          flexibleSpace: PreferredSize(
            preferredSize: Size.fromHeight(210.0),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ActionButton(
                    tamanhoBotao: 120.0,
                    simbolo: Icons.person,
                    tamanhoSimbolo: 75.0,
                    onPressed: null,
                  ),
                  Text(
                    widget.user.nomeUsuario,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          dadosUsuario("CPF", widget.user.cpf, Icons.edit, null),
          dadosUsuario("Senha", widget.user.senha, Icons.edit, null),
          dadosUsuario("Modelo do(s) carro(s)", widget.user.modeloCarro,
              Icons.edit, null),
          dadosUsuario("Sair do app", null, Icons.logout_rounded, _logOut()),
        ],
      ),
    );
  }

  Container dadosUsuario(
      String titulo, String? dado, IconData? icone, Function()? onPressed) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFB497F2),
            width: 1.5,
          ),
        ),
      ),
      child: ListTile(
        title: Text(titulo),
        subtitle: dado != null ? Text(dado) : null,
        trailing: icone != null
            ? IconButton(
                onPressed: onPressed,
                icon: Icon(
                  icone,
                  color: Color(0xFFEDE4E2),
                ),
              )
            : null,
      ),
    );
  }

  Function()? _logOut() {
    return () {
      logindata.setBool('login', true);
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => Login()));
    };
  }
}
