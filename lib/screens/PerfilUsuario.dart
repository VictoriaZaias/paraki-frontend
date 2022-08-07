import 'package:estacionamento/components/ActionButton.dart';
import 'package:estacionamento/models/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/DropdownSelect.dart';
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
  late TextEditingController novaSenhaController;
  late TextEditingController novaConfirmaSenhaController;
  late TextEditingController novoModeloCarroController;
  late SharedPreferences logindata;
  late String username;

  @override
  void initState() {
    super.initState();
    initial();
    novaSenhaController = TextEditingController();
    novaConfirmaSenhaController = TextEditingController();
    novoModeloCarroController = TextEditingController();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
    });
  }

  @override
  void dispose() {
    novaSenhaController.dispose();
    novaConfirmaSenhaController.dispose();
    novoModeloCarroController.dispose();
    super.dispose();
  }

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
          Container(
            decoration: decorationDadosPerfil(),
            child: ListTile(
              title: Text("CPF"),
              textColor: Color(0xFFEDE4E2),
              subtitle: Text(widget.user.cpf),
            ),
          ),
          Container(
            decoration: decorationDadosPerfil(),
            child: ListTile(
              title: Text("Senha"),
              textColor: Color(0xFFEDE4E2),
              subtitle: Text(widget.user.senha),
              trailing: IconButton(
                onPressed: () {
                  novaSenha(novaSenhaController, novaConfirmaSenhaController);
                },
                icon: Icon(
                  Icons.edit,
                  color: Color(0xFFEDE4E2),
                ),
              ),
            ),
          ),
          Container(
            decoration: decorationDadosPerfil(),
            child: ListTile(
              title: Text("Modelo do(s) carro(s)"),
              subtitle: Text(widget.user.modeloCarro),
              textColor: Color(0xFFEDE4E2),
              trailing: IconButton(
                onPressed: () {
                  novoModeloCarro();
                },
                icon: Icon(
                  Icons.edit,
                  color: Color(0xFFEDE4E2),
                ),
              ),
            ),
          ),
          Container(
            decoration: decorationDadosPerfil(),
            child: ListTile(
              title: Text("Sair"),
              textColor: Color(0xFFEDE4E2),
              trailing: IconButton(
                onPressed: _logOut(),
                icon: Icon(
                  Icons.logout_rounded,
                  color: Color(0xFFEDE4E2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration decorationDadosPerfil() {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Color(0xFFB497F2),
          width: 1.5,
        ),
      ),
    );
  }

  Future novaSenha(TextEditingController senha, TextEditingController confirmaSenha) {
    return showDialog(
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
          primary: Color(0xFFB497F2),
        )),
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            String? textoErro = "";
            return AlertDialog(
              title: Text("Senha"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    autofocus: true,
                    decoration:
                        InputDecoration(hintText: "Informe sua nova senha"),
                    controller: senha,
                  ),
                  SizedBox(height: 15),
                  TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Confirme sua nova senha",
                      helperText: textoErro,
                    ),
                    controller: confirmaSenha,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () {
                    if (senha.text ==
                        confirmaSenha.text) {
                          print("----------------------------");
                          print(senha.text);
                          print(confirmaSenha.text);
                          print("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKakks");
                      //chama serviço para alterar senha
                      Navigator.of(context).pop();
                    } else {
                      setState(() {
                        textoErro = "As senhas não são iguais.";
                      });
                      novaSenhaController.clear();
                      novaConfirmaSenhaController.clear();
                    }
                  },
                  child: Text("Salvar"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future novoModeloCarro() {
    String? carro;
    return showDialog(
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
          primary: Color(0xFFB497F2),
        )),
        child: AlertDialog(
          title: Text("Modelo do(s) carro(s)"),
          content: DropdownSelect(
            dica: "Tipo(s) de carro(s)",
            opcoes: ["Combustão", "Elétrico", "Combustão e elétrico"],
            valor: carro,
            getRotulo: (String valor) => valor,
            onChanged: (String? valor) => setState(() {
              carro = valor;
            }),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                String carroId;
                switch (carro) {
                  case 'Combustão':
                    carroId = '1';
                    break;
                  case 'Elétrico':
                    carroId = '2';
                    break;
                  case 'Combustão e elétrico':
                    carroId = '3';
                    break;
                  default:
                    carroId = '4';
                }
                Navigator.pop(context);
              },
              child: Text("Salvar"),
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
/*
class NovaSenhaDialog extends StatefulWidget {
  final TextEditingController? novaSenhaController;
  final TextEditingController? novaConfirmaSenhaController;

  const NovaSenhaDialog({
    Key? key,
    this.novaSenhaController,
    this.novaConfirmaSenhaController,
  }) : super(key: key);

  @override
  State<NovaSenhaDialog> createState() => _NovaSenhaDialogState();
}

class _NovaSenhaDialogState extends State<NovaSenhaDialog> {
  String? textoErro = "";
  @override
  Widget build(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
          primary: Color(0xFFB497F2),
        )),
        child: AlertDialog(
          title: Text("Senha"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                decoration: InputDecoration(hintText: "Informe sua nova senha"),
                controller: novaSenhaController,
              ),
              SizedBox(height: 15),
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Confirme sua nova senha",
                  helperText: textoErro,
                ),
                controller: novaConfirmaSenhaController,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                if (novaSenhaController.text ==
                    novaConfirmaSenhaController.text) {
                  //chama serviço para alterar senha
                  Navigator.of(context).pop();
                } else {
                  setState(() {
                    textoErro = "As senhas não são iguais.";
                  });
                  novaSenhaController.clear();
                  novaConfirmaSenhaController.clear();
                }
              },
              child: Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}*/
