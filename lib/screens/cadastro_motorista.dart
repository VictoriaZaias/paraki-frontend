import 'package:flutter/material.dart';
import '../components/editor.dart';
import 'principal_motorista.dart';

class CadastroMotorista extends StatelessWidget {
  const CadastroMotorista({Key? key}) : super(key: key);

  static const _tituloAppBar = 'Boas-vindas!';
  static const _rotuloCampoNomeMotorista = 'Nome completo';
  static const _rotuloCampoCPF = 'CPF';
  static const _dicaCampoCPF = '00000000000';
  static const _rotuloCampoSenha = 'Senha';
  static const _dicaCampoSenha = '00000000';
  static const _rotuloCampoConfirmaSenha = 'Confirmar senha';
  static const _dicaCampoConfirmaSenha = '00000000';
  static const _textoBotaoCadastrar = 'Cadastrar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: Text(
                  _tituloAppBar,
                  style: TextStyle(color: Color(0xFFEDE4E2), fontSize: 36.0),
                ),
              ),
              Editor(
                rotulo: _rotuloCampoNomeMotorista,
              ),
              Editor(
                rotulo: _rotuloCampoCPF,
                dica: _dicaCampoCPF,
                teclado: TextInputType.number,
              ),
              Editor(
                rotulo: 'Modelo do(s) carro(s)',
              ),
              Editor(
                rotulo: _rotuloCampoSenha,
                dica: _dicaCampoSenha,
              ),
              Editor(
                rotulo: _rotuloCampoConfirmaSenha,
                dica: _dicaCampoConfirmaSenha,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrincipalMotorista()));
                },
                child: Text(_textoBotaoCadastrar),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
