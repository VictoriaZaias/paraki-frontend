import 'package:estacionamento/http/UsuarioService.dart';
import 'package:estacionamento/screens/AcaoBemSucedida.dart';
import 'package:estacionamento/screens/Login.dart';
import 'package:flutter/material.dart';
import '../components/Button.dart';
import '../components/DropdownSelect.dart';
import '../components/Editor.dart';

import '../models/Usuario.dart';

class CadastroUsuario extends StatefulWidget {
  const CadastroUsuario({Key? key}) : super(key: key);

  @override
  State<CadastroUsuario> createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  static const _tituloTela = 'Boas-vindas!';
  static const _rotuloCampoNomeUsuario = 'Nome completo';
  static const _rotuloCampoCPF = 'CPF';
  static const _dicaCampoCPF = '00000000000';
  static const _rotuloCampoSenha = 'Senha';
  static const _dicaCampoSenha = '00000000';
  static const _rotuloCampoConfirmaSenha = 'Confirmar senha';
  static const _dicaCampoConfirmaSenha = '00000000';
  static const _textoBotaoCadastrar = 'Cadastrar';
  static TextEditingController nomeUsuario = TextEditingController();
  static TextEditingController cpf = TextEditingController();
  static TextEditingController senha = TextEditingController();
   static TextEditingController confirma = TextEditingController();
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
                  _tituloTela,
                  style: TextStyle(fontSize: 36.0),
                ),
              ),
              Editor(
                rotulo: _rotuloCampoNomeUsuario,
                controlador: nomeUsuario,
              ),
              Editor(
                rotulo: _rotuloCampoCPF,
                dica: _dicaCampoCPF,
                teclado: TextInputType.number,
                controlador: cpf,
              ),
              DropdownSelect(
                dica: "Tipo(s) de carro(s)",
                opcoes: ["Combustão", "Elétrico", "Combustão e elétrico"],
                valor: carro,
                getRotulo: (String valor) => valor,
                onChanged: (String? valor) => setState(() {
                  carro = valor;
                }),
              ),
              Editor(
                rotulo: _rotuloCampoSenha,
                dica: _dicaCampoSenha,
                controlador: senha,
                senha: true,
              ),
              Editor(
                rotulo: _rotuloCampoConfirmaSenha,
                dica: _dicaCampoConfirmaSenha,
                controlador: confirma,
                senha: true,
              ),
              Button(
                rotulo: _textoBotaoCadastrar,
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

                  if (validarSenha(senha.text, confirma.text)){
                      Usuario usuario = Usuario(
                        nomeUsuario.text, cpf.text, "2", carroId, senha.text);
                      UsuarioService().cadastrarUsuario(usuario);
                      Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AcaoBemSucedida("Cadastro efetuado com sucesso!"),
                    ),
                  );
                  }else{
                    senha.clear();
                    confirma.clear();
                  }
                  

                  
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validarSenha(String senha, String confirma){
    if (senha == confirma) {
      return true;
    }
    return false;
  }
}
