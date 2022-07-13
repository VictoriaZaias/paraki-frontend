import 'package:flutter/material.dart';
import '../components/button.dart';
import '../components/campo_tipo_carro.dart';
import '../components/editor.dart';
import '../models/usuario.dart';
import 'principal_usuario.dart';

class CadastroUsuario extends StatelessWidget {
  const CadastroUsuario({Key? key}) : super(key: key);

  static const _tituloAppBar = 'Boas-vindas!';
  static const _rotuloCampoNomeUsuarioCadastroUsuario = 'Nome completo';
  static const _rotuloCampoCPF = 'CPF';
  static const _dicaCampoCPF = '00000000000';
  static const _rotuloCampoSenha = 'Senha';
  static const _dicaCampoSenha = '00000000';
  static const _rotuloCampoConfirmaSenha = 'Confirmar senha';
  static const _dicaCampoConfirmaSenha = '00000000';
  static const _textoBotaoCadastrar = 'Cadastrar';
  static TextEditingController nomeUsuario = TextEditingController();
  static TextEditingController CPF = TextEditingController();
  static TextEditingController senha = TextEditingController();

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
                  style: TextStyle(fontSize: 36.0),
                ),
              ),
              Editor(
                rotulo: _rotuloCampoNomeUsuarioCadastroUsuario,
                controlador: nomeUsuario,
              ),
              Editor(
                rotulo: _rotuloCampoCPF,
                dica: _dicaCampoCPF,
                teclado: TextInputType.number,
                controlador: CPF,
              ),
              CampoTipoCarro(),
              Editor(
                rotulo: _rotuloCampoSenha,
                dica: _dicaCampoSenha,
                controlador: senha,
              ),
              Editor(
                rotulo: _rotuloCampoConfirmaSenha,
                dica: _dicaCampoConfirmaSenha,
              ),
              Button(
                rotulo: _textoBotaoCadastrar,
                onPressed: () {
                  CampoTipoCarro campo;
                  var valor =  _CampoTipoCarroState: ValueChanged;
                  print("TESTE:" + Campo());
                  Usuario usuario = Usuario(1, nomeUsuario.text , CPF.text, '1', '1', senha.text);
                  //cadastrarUsuario(usuario);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrincipalUsuario()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
