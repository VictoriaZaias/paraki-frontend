import 'package:estacionamento/http/UsuarioService.dart';
import 'package:estacionamento/models/Usuario.dart';
import 'package:flutter/material.dart';
import '../../components/ActionButton.dart';
import '../../components/Button.dart';
import '../../components/Editor.dart';
import '../AcaoBemSucedida.dart';

class AdminAltera extends StatefulWidget {
  const AdminAltera({Key? key}) : super(key: key);

  @override
  State<AdminAltera> createState() => _AdminAlteraState();
}

class _AdminAlteraState extends State<AdminAltera> {
  static const _rotuloCampoNomeUsuario = 'Nome completo';
  static const _rotuloTipoUsuario = 'Tipo usuário';
  static const _textoBotaoAtualizar = 'Atualizar';
  static TextEditingController nomeUsuarioControlador = TextEditingController();
  static TextEditingController cpfControlador = TextEditingController();
  static TextEditingController tipoUsuarioControlador = TextEditingController();
  Usuario usuario = Usuario("", "", "", "", "");

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
                controlador: cpfControlador,
                onSubmitted: (cpf) {
                  setState(() {
                    nomeUsuarioControlador.clear();
                    tipoUsuarioControlador.clear();
                    if (cpf!="") {
                      _fetchUsuario(cpf, nomeUsuarioControlador, tipoUsuarioControlador);
                    }
                    cpfControlador.clear();
                  });
                },
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Editor(
              rotulo: _rotuloCampoNomeUsuario,
              controlador: nomeUsuarioControlador,
              enabled: false,
            ),
            Editor(
              rotulo: _rotuloTipoUsuario,
              teclado: TextInputType.number,
              controlador: tipoUsuarioControlador,
              enabled: false,
            ),
            SizedBox(
              child: Column(
                children: [
                  Button(
                    rotulo: _textoBotaoAtualizar,
                    onPressed: () {
                      UsuarioService().alterarPermissao(usuario);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AcaoBemSucedida(
                                  "Usuário alterado com sucesso!")));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _fetchUsuario(String cpf, TextEditingController nome, TextEditingController tipo) async {
    if (cpf!="") {
      Usuario usuario = await UsuarioService().buscarUsuario(cpf);
      if (usuario != null){
        nome.text = usuario.nomeUsuario;
        tipo.text = usuario.tipo;
      }
    }
   
    
  }
}
