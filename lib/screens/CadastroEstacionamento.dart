import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/Button.dart';
import '../components/Editor.dart';
import '../components/ListaCaracteristicas.dart';

class CadastroEstacionamento extends StatelessWidget {
  static const _tituloTela = 'Estacionamento';
  static const _rotuloCampoNomeEstacionamento = 'Nome do estacionamento';
  static const _rotuloCampoCNPJ = 'CNPJ';
  static const _rotuloCampoCEP = 'CEP';
  static const _rotuloCampoEstado = 'Estado';
  static const _rotuloCampoCidade = 'Cidade';
  static const _rotuloCampoBairro = 'Bairro';
  static const _rotuloCampoLogradouro = 'Logradouro';
  static const _rotuloCampoNumero = 'Numero';
  static const _rotuloCampoTelefone = 'Telefone';
  static const _rotuloCampoTotalVagas = 'Quantidade de vagas';
  static const _textoBotaoCadastrar = 'Cadastrar';
  static TextEditingController nomeEstacionamento = TextEditingController();
  static TextEditingController cnpj = TextEditingController();
  static TextEditingController cep = TextEditingController();
  static TextEditingController estado = TextEditingController();
  static TextEditingController cidade = TextEditingController();
  static TextEditingController bairro = TextEditingController();
  static TextEditingController logradouro = TextEditingController();
  static TextEditingController numero = TextEditingController();
  static TextEditingController telefone = TextEditingController();
  static TextEditingController totalVagas = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0, bottom: 50.0),
                child: Text(
                  _tituloTela,
                  style: TextStyle(fontSize: 36.0),
                ),
              ),
              Editor(
                rotulo: _rotuloCampoNomeEstacionamento,
                controlador: nomeEstacionamento,
              ),
              Editor(
                rotulo: _rotuloCampoCNPJ,
                controlador: cnpj,
              ),
              Editor(
                rotulo: _rotuloCampoCEP,
                controlador: cep,
              ),
              Editor(
                rotulo: _rotuloCampoEstado,
                controlador: estado,
              ),
              Editor(
                rotulo: _rotuloCampoCidade,
                controlador: cidade,
              ),
              Editor(
                rotulo: _rotuloCampoBairro,
                controlador: bairro,
              ),
              Editor(
                rotulo: _rotuloCampoLogradouro,
                controlador: logradouro,
              ),
              Editor(
                rotulo: _rotuloCampoNumero,
                controlador: numero,
              ),
              Editor(
                rotulo: _rotuloCampoTelefone,
                controlador: telefone,
              ),
              Editor(
                rotulo: _rotuloCampoTotalVagas,
                controlador: totalVagas,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Selecione as caracteristicas:",
                  style: TextStyle(fontSize: 18),
                  //textDirection: TextDirection.(ltr,
                ),
              ),
              ListaCaracteristicas(),
              Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: Button(
                  rotulo: _textoBotaoCadastrar,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
