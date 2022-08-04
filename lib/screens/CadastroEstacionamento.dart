import 'package:estacionamento/components/ContainerDados.dart';
import 'package:estacionamento/components/TimePicker.dart';
import 'package:estacionamento/http/EnderecoService.dart';
import 'package:estacionamento/http/estacionamentoService.dart';
import 'package:estacionamento/models/Caracteristica.dart';
import 'package:estacionamento/models/Estacionamento.dart';
import 'package:estacionamento/models/HorarioFuncionamento.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/Button.dart';
import '../components/Editor.dart';
import '../components/ListaCaracteristicas.dart';
import '../http/CaracteristicaService.dart';
import '../models/Endereco.dart';

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
  static const _rotuloCampovalorHora = 'Preço por hora';
  static const _textoBotaoCadastrar = 'Cadastrar';
  static TextEditingController nomeEstacionamento = TextEditingController();
  static TextEditingController cnpj = TextEditingController();
  static TextEditingController cep = TextEditingController();
  static TextEditingController numero = TextEditingController();
  static TextEditingController telefone = TextEditingController();
  static TextEditingController totalVagas = TextEditingController();
  static TextEditingController valorHora = TextEditingController();
  static List<TimeOfDay> aberturasEstacionamento =
      List<TimeOfDay>.filled(3, TimeOfDay(hour: 0, minute: 0));
  static List<TimeOfDay> fechamentosEstacionamento =
      List<TimeOfDay>.filled(3, TimeOfDay(hour: 0, minute: 0));
  static List<Caracteristica> caracteristicas = [];
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
              Editor(
                rotulo: _rotuloCampovalorHora,
                controlador: valorHora,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: SizedBox(
                  width: 300.0,
                  child: Column(
                    children: _dadosHorarios(
                        aberturasEstacionamento, fechamentosEstacionamento),
                  ),
                ),
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
                            vertical: 10.0, horizontal: 15.0),
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
                          isChecked: caracteristicas,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: Button(
                  rotulo: _textoBotaoCadastrar,
                  onPressed: () async {
                    print('-------------------------------');
                    print(caracteristicas);
                    print('-------------------------------');

                    Endereco endereco =
                        await EnderecoService().buscarPorCEP(cep.text);
                    EnderecoService().cadastrarEndereco(endereco);
                    int idEndereco =
                        await EnderecoService().buscarIdCEP(endereco.cep);

                    String horarioAberturaSemana =
                        aberturasEstacionamento[0].hour.toString() +
                            ":" +
                            aberturasEstacionamento[0].minute.toString() +
                            ":00";
                    String horarioFechamentoSemana =
                        fechamentosEstacionamento[0].hour.toString() +
                            ":" +
                            fechamentosEstacionamento[0].minute.toString() +
                            ":00";
                    String horarioAberturaSab =
                        aberturasEstacionamento[1].hour.toString() +
                            ":" +
                            aberturasEstacionamento[1].minute.toString() +
                            ":00";
                    String horarioFechamentoSab =
                        fechamentosEstacionamento[1].hour.toString() +
                            ":" +
                            fechamentosEstacionamento[1].minute.toString() +
                            ":00";
                    String horarioAberturaDom =
                        aberturasEstacionamento[2].hour.toString() +
                            ":" +
                            aberturasEstacionamento[2].minute.toString() +
                            ":00";
                    String horarioFechamentoDom =
                        fechamentosEstacionamento[2].hour.toString() +
                            ":" +
                            fechamentosEstacionamento[2].minute.toString() +
                            ":00";

                    List<HorarioFuncionamento> horarios = [];
                    horarios.length = 3;
                    horarios[0] = HorarioFuncionamento(0, horarioAberturaSemana,
                        horarioFechamentoSemana, "Seg-Sex");
                    horarios[1] = HorarioFuncionamento(
                        0, horarioAberturaSab, horarioFechamentoSab, "Sáb");
                    horarios[2] = HorarioFuncionamento(
                        0, horarioAberturaDom, horarioFechamentoDom, "Dom");

                    print('Testeeeeeeeeeee $idEndereco');
                    Estacionamento estacionamento = Estacionamento(
                      0,
                      nomeEstacionamento.text,
                      cnpj.text,
                      int.parse(totalVagas.text),
                      int.parse(totalVagas.text),
                      int.parse(numero.text),
                      telefone.text,
                      double.parse(valorHora.text),
                      endereco,
                      horarios: horarios,
                      caracteristicas: caracteristicas,
                    );
                    EstacionamentoService()
                        .cadastrarEstacionamento(estacionamento, idEndereco);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _dadosHorarios(List<TimeOfDay> aberturasEstacionamento,
      List<TimeOfDay> fechamentosEstacionamento) {
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
      _horarioDia(
          "Seg-Sex:", aberturasEstacionamento[0], fechamentosEstacionamento[0]),
      _horarioDia(
          "Sáb:", aberturasEstacionamento[1], fechamentosEstacionamento[1]),
      _horarioDia(
          "Dom:", aberturasEstacionamento[2], fechamentosEstacionamento[2]),
    ];
  }

  Widget _horarioDia(String titulo, TimeOfDay abertura, TimeOfDay fechamento) {
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
                TimePicker(
                  selectedTime: abertura,
                ),
                Text(" - "),
                TimePicker(
                  selectedTime: fechamento,
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
/*
  Widget _relogio(TimeOfDay horario) {
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
  }*/
}
