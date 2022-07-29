import 'package:estacionamento/components/ContainerDados.dart';
import 'package:estacionamento/screens/Admin/AdminValida.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/Button.dart';
import '../Login.dart';
import 'AdminCadastro.dart';
import 'AdminAltera.dart';

class PrincipalAdmin extends StatefulWidget {
  const PrincipalAdmin({Key? key}) : super(key: key);

  @override
  State<PrincipalAdmin> createState() => _PrincipalAdminState();
}

class _PrincipalAdminState extends State<PrincipalAdmin> {
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
            _menuUsuario(),
            _menuEstacionamento(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _logOut(),
        child: Icon(
          Icons.logout_rounded,
          color: Color(0xFFEDE4E2),
        ),
      ),
    );
  }

  Widget _menuUsuario() {
    return Container(
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
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminCadastro()));
              },
            ),
            Button(
              rotulo: "Alterar",
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminAltera()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuEstacionamento() {
    return Container(
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
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
                  child: Text(
                    "Estacionamento",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Button(
              rotulo: "Validar",
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminValida()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Function()? _logOut() {
    return () {
      logindata.setBool('login', true);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Login()),
          (Route<dynamic> route) => false);
    };
  }
}
