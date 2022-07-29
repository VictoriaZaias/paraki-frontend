import 'package:flutter/material.dart';
import '../../components/ActionButton.dart';
import '../../components/Button.dart';
import '../../components/DropdownSelect.dart';
import '../../components/Editor.dart';
import '../Agradecimento.dart';

class AdminAltera extends StatefulWidget {
  const AdminAltera({Key? key}) : super(key: key);

  @override
  State<AdminAltera> createState() => _AdminAlteraState();
}

class _AdminAlteraState extends State<AdminAltera> {
  static const _rotuloCampoNomeUsuarioCadastroUsuario = 'Nome completo';
  static const _rotuloCampoCPF = 'CPF';
  static const _dicaCampoCPF = '00000000000';
  static const _rotuloCampoSenha = 'Senha';
  static const _dicaCampoSenha = '00000000';
  static const _textoBotaoAtualizar = 'Atualizar';
  static const _textoBotaoInativar = 'Inativar';
  static TextEditingController nomeUsuario = TextEditingController();
  static TextEditingController cpf = TextEditingController();
  static TextEditingController senha = TextEditingController();
  static String? carro;
  static String? vinculoUsuario;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(165.0),
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
            "Alterar",
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFB497F2),
                  ),
                ),
              ),
              child: Editor(
                rotulo: 'Pesquise pelo CPF',
                largura: 350.0,
                icone: Icons.search,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
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
            SizedBox(
              child: Column(
                children: [
                  Button(
                    rotulo: _textoBotaoAtualizar,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Agradecimento("atualizado")));
                    },
                  ),
                  /*
                  Button(
                    rotulo: _textoBotaoInativar,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Agradecimento("inativado")));
                    },
                  ),
                  */
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
