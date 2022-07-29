import 'package:estacionamento/components/ActionButton.dart';
import 'package:estacionamento/components/ContainerDados.dart';
import 'package:estacionamento/components/DropdownSelect.dart';
import 'package:estacionamento/models/Caracteristica.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/Button.dart';
import '../components/CenteredMessage.dart';
import '../components/CheckboxCaracteristica.dart';
import '../components/Editor.dart';
import '../components/ListaCaracteristicas.dart';
import '../components/Progress.dart';
import '../http/CaracteristicaService.dart';

class CadastroEstacionamento extends StatefulWidget {
  final int idUsuario;

  CadastroEstacionamento(
    this.idUsuario, {
    Key? key,
  }) : super(key: key);

  @override
  State<CadastroEstacionamento> createState() => _CadastroEstacionamentoState();
}

class _CadastroEstacionamentoState extends State<CadastroEstacionamento> {
  static const _tituloTela = 'Estacionamento';
  static const _rotuloCampoNomeEstacionamento = 'Nome do estacionamento';
  static const _rotuloCampoCNPJ = 'CNPJ';
  static const _rotuloCampoCEP = 'CEP';
  static const _rotuloCampoNumero = 'Numero';
  static const _rotuloCampoTelefone = 'Telefone';
  static const _rotuloCampoTotalVagas = 'Quantidade de vagas';
  static const _rotuloCampoPreco = 'Preço por hora';
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
  static TextEditingController preco = TextEditingController();

  NumberFormat numberFormat = new NumberFormat("00");

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
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  width: 300.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFB497F2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Selecione as caracteristicas:",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 180.0,
                        child: ListaCaracteristicas(
                          CaracteristicaService().listarTodasCaracteristicas(),
                          isCheckbox: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: SizedBox(
                  width: 300.0,
                  child: Column(
                    children: _dadosHorarios(),
                  ),
                ),
              ),
              Editor(
                rotulo: _rotuloCampoPreco,
                controlador: preco,
              ),
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

  List<Widget> _dadosHorarios() {
    return [
      Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: Text(
          "Horários:",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      _horarioDia("Seg-Sex:"),
      _horarioDia("Sáb:"),
      _horarioDia("Dom:"),
    ];
  }

  Widget _horarioDia(String titulo) {
    return ContainerDados(
      dados: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titulo,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            Row(
              children: [
                _relogio(),
                Text(" - "),
                _relogio(),
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _relogio() {
    TimeOfDay horario = TimeOfDay(hour: 0, minute: 0);
    return OutlinedButton(
      onPressed: () async {
        final newTime = await showTimePicker(
          context: context,
          initialTime: horario,
          builder: (context, child) {
            return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child ?? Container(),
            );
          },
        );
        if (newTime != null) {
          setState(() {
            horario = newTime;
          });
        }
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        )),
      ),
      child: Text(
          '${numberFormat.format(horario.hour).toString()}:${numberFormat.format(horario.minute).toString()}'),
    );
  }
}
