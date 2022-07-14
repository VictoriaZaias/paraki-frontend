import 'package:flutter/material.dart';
import '../components/Button.dart';
import '../components/Editor.dart';
import 'CadastroUsuario.dart';
import 'PrincipalUsuario.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  static const _rotuloCampoCPF = 'CPF';
  static const _dicaCampoCPF = '00000000000';
  static const _rotuloCampoSenha = 'Senha';
  static const _dicaCampoSenha = '00000000';
  static const _textoBotaoEntrar = 'Entrar';
  static const _textoBotaoCadastrar = 'Cadastrar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Editor(
                rotulo: _rotuloCampoCPF,
                dica: _dicaCampoCPF,
                teclado: TextInputType.number,
              ),
              Editor(
                rotulo: _rotuloCampoSenha,
                dica: _dicaCampoSenha,
              ),
              Button(
                rotulo: _textoBotaoEntrar,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrincipalUsuario()));
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
