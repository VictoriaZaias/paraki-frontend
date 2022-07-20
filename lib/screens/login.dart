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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                //Image.asset('assets/images/paraki.png'),
                Editor(
                  controlador: _controladorCpf,
                  validacao: _validateLogin,
                  rotulo: _rotuloCampoCPF,
                  dica: _dicaCampoCPF,
                  teclado: TextInputType.number,
                ),
                Editor(
                  controlador: _controladorSenha,
                  validacao: _validateSenha,
                  rotulo: _rotuloCampoSenha,
                  dica: _dicaCampoSenha,
                ),
                Button(
                  rotulo: _textoBotaoEntrar,
                  onPressed: () {
                    final login = _controladorCpf.text;
                    final senha = _controladorSenha.text;

                    if (_formKey.currentState!.validate()) {
                      return Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrincipalUsuario()));
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
      ),
    );
  }

  String? _validateLogin(String? text) {
    if (text == null || text.isEmpty) {
      return "Informe o CPF";
    }
  }

  String? _validateSenha(String? text) {
    if (text == null || text.isEmpty) {
      return "Informe a senha";
    }
  }
}
