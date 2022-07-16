import 'package:flutter/material.dart';
import '../components/Button.dart';
import '../components/CampoTipoCarro.dart';
import '../components/Editor.dart';
import '../http/UsuarioService.dart';
import '../models/Usuario.dart';
import 'PrincipalUsuario.dart';

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
  static String? carro;

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
              CampoTipoCarro(
                dropdownValue: carro,
              ),
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
                  String carroId;
                  switch (carro) {
                    case 'Elétrico':
                      carroId = '1';
                      break;
                    case 'Combustão':
                      carroId = '2';
                      break;
                    case 'Combustão e elétrico':
                      carroId = '3';
                      break;
                    default:
                      carroId = '4';
                  }
                  Usuario usuario = Usuario(
                      1, nomeUsuario.text, CPF.text, '2', carroId, senha.text);
                  cadastrarUsuario(usuario);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrincipalUsuario(),
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
}
