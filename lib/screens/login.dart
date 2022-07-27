import 'package:estacionamento/http/LoginService.dart';
import 'package:estacionamento/models/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/Button.dart';
import '../components/Editor.dart';
import 'Admin/PrincipalAdmin.dart';
import 'CadastroUsuario.dart';
import 'PrincipalUsuario.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static const _rotuloCampoCPF = 'CPF';
  static const _dicaCampoCPF = '00000000000';
  static const _rotuloCampoSenha = 'Senha';
  static const _dicaCampoSenha = '00000000';
  static const _textoBotaoEntrar = 'Entrar';
  static const _textoBotaoCadastrar = 'Cadastrar';

  final TextEditingController _controladorCpf = TextEditingController();
  final TextEditingController _controladorSenha = TextEditingController();

  //
  late SharedPreferences logindata;
  late bool newuser;

  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Usuario u = Usuario(
        logindata.getInt('id_user')!,
        logindata.getString('username')!,
        logindata.getString('cpf')!,
        logindata.getString('tipo_usere')!,
        logindata.getString('modelo_carro')!,
        logindata.getString('senha_user')!,
      );
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (context) => PrincipalUsuario(user: u)));
    }
  }

  @override
  void dispose() {
    _controladorCpf.dispose();
    _controladorSenha.dispose();
    super.dispose();
  }
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //Image.asset('assets/images/paraki.png'),
              Editor(
                controlador: _controladorCpf,
                rotulo: _rotuloCampoCPF,
                dica: _dicaCampoCPF,
                teclado: TextInputType.number,
              ),
              Editor(
                controlador: _controladorSenha,
                rotulo: _rotuloCampoSenha,
                dica: _dicaCampoSenha,
                senha: true,
              ),
              Button(
                rotulo: _textoBotaoEntrar,
                onPressed: () async {
                  /*
                  // Teste pra quando fica sem net
                  Usuario u = Usuario(1, 'vick', '123', '2', '1', '123');

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PrincipalUsuario(user: u)),
                  );
                  */

                  var usuario = await LoginService().validarLogin(
                      _controladorCpf.text, _controladorSenha.text);
                  if (usuario.tipo == "Motorista") {
                    Usuario u = Usuario(
                      usuario.idUsuario,
                      usuario.nomeUsuario,
                      usuario.cpf,
                      usuario.tipo,
                      usuario.modeloCarro,
                      usuario.senha,
                    );
                    logindata.setBool('login', false);
                    logindata.setInt('id_user', usuario.idUsuario);
                    logindata.setString('username', usuario.nomeUsuario);
                    logindata.setString('cpf', usuario.cpf);
                    logindata.setString('tipo_usere', usuario.tipo);
                    logindata.setString('modelo_carro', usuario.modeloCarro);
                    logindata.setString('senha_user', usuario.senha);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrincipalUsuario(user: u)),
                    );
                  } else if (usuario.tipo == "Administrador") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => PrincipalAdmin()),
                    );
                  }
                },
              ),
              TextButton(
                child: Text(_textoBotaoCadastrar),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CadastroUsuario()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
