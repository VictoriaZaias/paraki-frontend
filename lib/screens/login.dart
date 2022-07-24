import 'package:estacionamento/http/LoginService.dart';
import 'package:estacionamento/models/Usuario.dart';
import 'package:estacionamento/screens/PrincipalAdmin.dart';
import 'package:flutter/material.dart';
import '../components/Button.dart';
import '../components/Editor.dart';
import 'CadastroUsuario.dart';
import 'PrincipalUsuario.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  static const _rotuloCampoCPF = 'CPF';
  static const _dicaCampoCPF = '00000000000';
  static const _rotuloCampoSenha = 'Senha';
  static const _dicaCampoSenha = '00000000';
  static const _textoBotaoEntrar = 'Entrar';
  static const _textoBotaoCadastrar = 'Cadastrar';

  final TextEditingController _controladorCpf = TextEditingController();
  final TextEditingController _controladorSenha = TextEditingController();

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
                    /*
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrincipalUsuario(user: u)),
                    );*/

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrincipalUsuario(user: u)),
                    );
                  } else if (usuario.tipo == "Administrador") {
                    Navigator.push(
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

  String? _validateLogin(String text) {
    if (text.isEmpty) {
      return "Informe o login";
    }
    return null;
  }

  String? _validateSenha(String text) {
    if (text.isEmpty) {
      return "Informe a senha";
    }
    return null;
  }
}
