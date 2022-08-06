import 'package:estacionamento/components/ContainerDados.dart';
import 'package:estacionamento/components/TimePicker.dart';
import 'package:estacionamento/http/EnderecoService.dart';
import 'package:estacionamento/http/estacionamentoService.dart';
import 'package:estacionamento/models/Caracteristica.dart';
import 'package:estacionamento/models/Estacionamento.dart';
import 'package:estacionamento/models/HorarioFuncionamento.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../components/Button.dart';
import '../../components/Editor.dart';
import '../../components/ListaCaracteristicas.dart';
import '../../http/CaracteristicaService.dart';
import '../../models/Endereco.dart';

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
  static const _rotuloCampoLogradouro = 'Logradouro';
  static const _rotuloCampoBairro = 'Bairro';
  static const _rotuloCampoCidade = 'Cidade';
  static const _rotuloCampoUnidadeFederativa = 'Estado';
  static const _rotuloCampoNumero = 'Numero';
  static const _rotuloCampoTelefone = 'Telefone';
  static const _rotuloCampoTotalVagas = 'Quantidade de vagas';
  static const _rotuloCampovalorHora = 'Preço por hora';
  static const _textoBotaoCadastrar = 'Cadastrar';
  static TextEditingController nomeEstacionamento = TextEditingController();
  static TextEditingController cnpj = TextEditingController();
  static TextEditingController cep = TextEditingController();
  static TextEditingController logradouro = TextEditingController();
  static TextEditingController bairro = TextEditingController();
  static TextEditingController cidade = TextEditingController();
  static TextEditingController unidadeFederativa = TextEditingController();
  static TextEditingController numero = TextEditingController();
  static TextEditingController telefone = TextEditingController();
  static TextEditingController totalVagas = TextEditingController();
  static TextEditingController valorHora = TextEditingController();
  static List<TimeOfDay> aberturasEstacionamento =
      List<TimeOfDay>.filled(3, TimeOfDay(hour: 0, minute: 0));
  static List<TimeOfDay> fechamentosEstacionamento =
      List<TimeOfDay>.filled(3, TimeOfDay(hour: 0, minute: 0));
  ListaCaracteristicas? listaCaracteristicas;
  static List<Caracteristica> caracteristicas = [];
  NumberFormat numberFormat = new NumberFormat("00");

  @override
  void initState() {
    //pegaCaracteristicas();
    listaCaracteristicas = ListaCaracteristicas(
      CaracteristicaService().listarTodasCaracteristicas(),
      isCheckbox: true,
      isChecked: caracteristicas,
    );
    super.initState();
  }

/*
  pegaCaracteristicas() async {
    listaCaracteristicas = await ListaCaracteristicas(
      CaracteristicaService().listarTodasCaracteristicas(),
      isCheckbox: true,
      isChecked: caracteristicas,
    );
  }
*/
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
                teclado: TextInputType.number,
                controlador: cnpj,
              ),
              Editor(
                rotulo: _rotuloCampoCEP,
                teclado: TextInputType.number,
                controlador: cep,
                onSubmitted: (cep) {
                  setState(() {
                    _fetchEndereco(
                        cep, logradouro, bairro, cidade, unidadeFederativa);
                  });
                },
              ),
              Editor(
                rotulo: _rotuloCampoLogradouro,
                controlador: logradouro,
                enabled: false,
              ),
              Editor(
                rotulo: _rotuloCampoBairro,
                controlador: bairro,
                enabled: false,
              ),
              Editor(
                rotulo: _rotuloCampoCidade,
                controlador: cidade,
                enabled: false,
              ),
              Editor(
                rotulo: _rotuloCampoUnidadeFederativa,
                controlador: unidadeFederativa,
                enabled: false,
              ),
              Editor(
                rotulo: _rotuloCampoNumero,
                teclado: TextInputType.number,
                controlador: numero,
              ),
              Editor(
                rotulo: _rotuloCampoTelefone,
                teclado: TextInputType.number,
                controlador: telefone,
              ),
              Editor(
                rotulo: _rotuloCampoTotalVagas,
                teclado: TextInputType.number,
                controlador: totalVagas,
              ),
              Editor(
                rotulo: _rotuloCampovalorHora,
                teclado: TextInputType.number,
                controlador: valorHora,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: SizedBox(
                  width: 300.0,
                  child: Column(
                    children: [
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
                      ContainerDados(
                        dados: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Seg-Sex:",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              Row(
                                children: [
                                  TimePicker(
                                    onTimeChanged: (newTime) {
                                      aberturasEstacionamento[0] = newTime;
                                    },
                                  ),
                                  Text(" - "),
                                  TimePicker(
                                    onTimeChanged: (newTime) {
                                      fechamentosEstacionamento[0] = newTime;
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      ContainerDados(
                        dados: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sáb:",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              Row(
                                children: [
                                  TimePicker(
                                    onTimeChanged: (newTime) {
                                      aberturasEstacionamento[1] = newTime;
                                    },
                                  ),
                                  Text(" - "),
                                  TimePicker(
                                    onTimeChanged: (newTime) {
                                      fechamentosEstacionamento[1] = newTime;
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      ContainerDados(
                        dados: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Dom:",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              Row(
                                children: [
                                  TimePicker(
                                    onTimeChanged: (newTime) {
                                      aberturasEstacionamento[2] = newTime;
                                    },
                                  ),
                                  Text(" - "),
                                  TimePicker(
                                    onTimeChanged: (newTime) {
                                      fechamentosEstacionamento[2] = newTime;
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
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
                        height: 180,
                        /** caracteristicas.length,*/
                        child: listaCaracteristicas,
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
                    Endereco endereco = Endereco(
                        1,
                        bairro.text,
                        logradouro.text,
                        cidade.text,
                        unidadeFederativa.text,
                        cep.text);
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
                    horarios.add(HorarioFuncionamento(0, horarioAberturaSemana,
                        horarioFechamentoSemana, "semanal"));
                    horarios.add(HorarioFuncionamento(
                        0, horarioAberturaSab, horarioFechamentoSab, "Sab"));
                    horarios.add(HorarioFuncionamento(
                        0, horarioAberturaDom, horarioFechamentoDom, "Dom"));

                    Estacionamento estacionamento = Estacionamento(
                      nomeEstacionamento: nomeEstacionamento.text,
                      cnpj: cnpj.text,
                      qtdTotalVagas: int.parse(totalVagas.text),
                      nroEstacionamento: int.parse(numero.text),
                      telefone: telefone.text,
                      valorHora: double.parse(valorHora.text),
                      endereco: endereco,
                      horarios: horarios,
                      caracteristicas: caracteristicas,
                    );
                    EstacionamentoService().cadastrarEstacionamento(
                        estacionamento, idEndereco, widget.idUsuario);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _fetchEndereco(
      String cep,
      TextEditingController logradouro,
      TextEditingController bairro,
      TextEditingController cidade,
      TextEditingController uf) async {
    Endereco endereco = await EnderecoService().buscarPorCEP(cep);
    logradouro.text = endereco.logradouro;
    bairro.text = endereco.bairro;
    cidade.text = endereco.cidade;
    uf.text = endereco.unidadeFederativa;
  }
}
