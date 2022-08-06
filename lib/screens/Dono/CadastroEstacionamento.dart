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
import '../../http/UsuarioService.dart';
import '../../models/Endereco.dart';
import '../AcaoBemSucedida.dart';

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
  static TextEditingController nomeEstacionamentoControlador =
      TextEditingController();
  static TextEditingController cnpjControlador = TextEditingController();
  static TextEditingController cepControlador = TextEditingController();
  static TextEditingController logradouroControlador = TextEditingController();
  static TextEditingController bairroControlador = TextEditingController();
  static TextEditingController cidadeControlador = TextEditingController();
  static TextEditingController unidadeFederativaControlador =
      TextEditingController();
  static TextEditingController numeroControlador = TextEditingController();
  static TextEditingController telefoneControlador = TextEditingController();
  static TextEditingController totalVagasControlador = TextEditingController();
  static TextEditingController valorHoraControlador = TextEditingController();
  static List<TimeOfDay> aberturasEstacionamento =
      List<TimeOfDay>.filled(3, TimeOfDay(hour: 0, minute: 0));
  static List<TimeOfDay> fechamentosEstacionamento =
      List<TimeOfDay>.filled(3, TimeOfDay(hour: 0, minute: 0));
  ListaCaracteristicas? listaCaracteristicas;
  static List<Caracteristica> caracteristicas = [];
  NumberFormat numberFormat = new NumberFormat("00");

  String? textoErroCNPJ = null;
  bool cnpjValidacao = false;

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
  void dispose() {
    nomeEstacionamentoControlador.dispose();
    cnpjControlador.dispose();
    cepControlador.dispose();
    logradouroControlador.dispose();
    bairroControlador.dispose();
    cidadeControlador.dispose();
    unidadeFederativaControlador.dispose();
    numeroControlador.dispose();
    telefoneControlador.dispose();
    totalVagasControlador.dispose();
    valorHoraControlador.dispose();
    super.dispose();
  }

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
                controlador: nomeEstacionamentoControlador,
              ),
              Editor(
                rotulo: _rotuloCampoCNPJ,
                teclado: TextInputType.number,
                textoErro: textoErroCNPJ,
                controlador: cnpjControlador,
                onSubmitted: (cnpj) async {
                  cnpjValidacao =
                      await EstacionamentoService().validarCNPJ(cnpj);
                },
              ),
              Editor(
                rotulo: _rotuloCampoCEP,
                teclado: TextInputType.number,
                controlador: cepControlador,
                onSubmitted: (cep) {
                  setState(() {
                    _fetchEndereco(
                        cep,
                        logradouroControlador,
                        bairroControlador,
                        cidadeControlador,
                        unidadeFederativaControlador);
                  });
                },
              ),
              Editor(
                rotulo: _rotuloCampoLogradouro,
                controlador: logradouroControlador,
                enabled: false,
              ),
              Editor(
                rotulo: _rotuloCampoBairro,
                controlador: bairroControlador,
                enabled: false,
              ),
              Editor(
                rotulo: _rotuloCampoCidade,
                controlador: cidadeControlador,
                enabled: false,
              ),
              Editor(
                rotulo: _rotuloCampoUnidadeFederativa,
                controlador: unidadeFederativaControlador,
                enabled: false,
              ),
              Editor(
                rotulo: _rotuloCampoNumero,
                teclado: TextInputType.number,
                controlador: numeroControlador,
              ),
              Editor(
                rotulo: _rotuloCampoTelefone,
                teclado: TextInputType.number,
                controlador: telefoneControlador,
              ),
              Editor(
                rotulo: _rotuloCampoTotalVagas,
                teclado: TextInputType.number,
                controlador: totalVagasControlador,
              ),
              Editor(
                rotulo: _rotuloCampovalorHora,
                teclado: TextInputType.number,
                controlador: valorHoraControlador,
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
                    if (cnpjValidacao) {
                      Endereco endereco = Endereco(
                          1,
                          bairroControlador.text,
                          logradouroControlador.text,
                          cidadeControlador.text,
                          unidadeFederativaControlador.text,
                          cepControlador.text);
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
                      horarios.add(HorarioFuncionamento(
                          0,
                          horarioAberturaSemana,
                          horarioFechamentoSemana,
                          "semanal"));
                      horarios.add(HorarioFuncionamento(
                          0, horarioAberturaSab, horarioFechamentoSab, "Sab"));
                      horarios.add(HorarioFuncionamento(
                          0, horarioAberturaDom, horarioFechamentoDom, "Dom"));

                      Estacionamento estacionamento = Estacionamento(
                        nomeEstacionamento: nomeEstacionamentoControlador.text,
                        cnpj: cnpjControlador.text,
                        qtdTotalVagas: int.parse(totalVagasControlador.text),
                        nroEstacionamento: int.parse(numeroControlador.text),
                        telefone: telefoneControlador.text,
                        valorHora: double.parse(valorHoraControlador.text),
                        endereco: endereco,
                        horarios: horarios,
                        caracteristicas: caracteristicas,
                      );
                      EstacionamentoService().cadastrarEstacionamento(
                          estacionamento, idEndereco, widget.idUsuario);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AcaoBemSucedida(
                              "Estacionamento cadastrado com sucesso!"),
                        ),
                      );
                    } else {
                      setState(() {
                        textoErroCNPJ = "CNPJ inválido.";
                      });
                      cnpjControlador.clear();
                    }
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
