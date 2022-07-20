import 'package:estacionamento/screens/Agradecimento.dart';
import 'package:flutter/material.dart';
import '../components/ActionButton.dart';
import '../components/Button.dart';
import '../components/DropdownSelect.dart';
import '../components/Editor.dart';
import '../http/UsuarioService.dart';
import '../models/Usuario.dart';
import 'Login.dart';
import 'PrincipalAdmin.dart';

class AdminCadastro extends StatefulWidget {
  const AdminCadastro({Key? key}) : super(key: key);

  @override
  State<AdminCadastro> createState() => _AdminCadastroState();
}

class _AdminCadastroState extends State<AdminCadastro> {
  static const _rotuloCampoNomeUsuarioCadastroUsuario = 'Nome completo';
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
  static String? carro;
  static String? vinculoUsuario;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          toolbarHeight: 90.0,
          leadingWidth: 90.0,
          leading: ActionButton(
            simbolo: Icons.arrow_back,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            "Cadastro usuário",
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Editor(
                rotulo: _rotuloCampoNomeUsuarioCadastroUsuario,
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
                onChanged: (String? valor) => setState(() {
                  carro = valor;
                }),
                getRotulo: (String valor) => valor,
              ),
              DropdownSelect(
                dica: "Tipo usuário",
                opcoes: ["Motorista", "Dono de estacionamento"],
                valor: vinculoUsuario,
                onChanged: (String? valor) => setState(() {
                  vinculoUsuario = valor;
                }),
                getRotulo: (String valor) => valor,
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
                senha: true,
              ),
              Button(
                rotulo: _textoBotaoCadastrar,
                onPressed: () {
                  String carroId, vinculoId;
                  switch (vinculoUsuario) {
                    case 'Motorista':
                      vinculoId = '2';
                      break;
                    case 'Dono de estacionamento':
                      vinculoId = '3';
                      break;
                    default:
                      vinculoId = '4';
                  }
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
                  Usuario usuario = Usuario(1, nomeUsuario.text, cpf.text,
                      vinculoId, carroId, senha.text);
                  cadastrarUsuario(usuario);
                  
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Agradecimento("cadastrado")));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
