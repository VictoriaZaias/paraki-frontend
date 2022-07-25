import 'package:estacionamento/http/EnderecoService.dart';
import 'package:estacionamento/http/HorarioFuncionamentoService.dart';
import 'package:estacionamento/models/Estacionamento.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'dart:convert';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print(data.toString());
    print('Request');
    print('url: ${data.url}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print(data.toString());
    print('Response');
    print('status code: ${data.statusCode}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }
}

class estacionamentoService {
  String urlPadrao = "http://estacionamento-pedepano.herokuapp.com/paraki/";

  String enderecoCompleto(Estacionamento estacionamento) {
    String enderecoCompleto;
    enderecoCompleto = estacionamento.endereco.tipoLogradouro +
        " " +
        estacionamento.endereco.logradouro +
        ", " +
        estacionamento.nroEstacionamento.toString() +
        " - " +
        estacionamento.endereco.bairro +
        "\n" +
        estacionamento.endereco.cidade +
        " - " +
        estacionamento.endereco.unidadeFederativa +
        ", " +
        estacionamento.endereco.cep;
    return enderecoCompleto;
  }

  Future<List<Estacionamento>> listarEstacionamento() async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    final response =
        await client.get(Uri.parse('${urlPadrao}estacionamento/listar'));
    final List<Estacionamento> estacionamentos = [];
    var estacionamentoJson = jsonDecode(response.body);

    for (var json in estacionamentoJson['result']) {
      var endereco = await EnderecoService().buscarEndereco(json['endereco']);
      var horarios = await HorarioFuncionamentoService().listarHorarios(json['idEstacionamento']);
      final Estacionamento estacionamento = Estacionamento(
          json['idEstacionamento'],
          json['nomeEstacionamento'],
          json['CNPJ'],
          json['qtdTotalVagas'],
          json['qtdVagasDisponiveis'],
          json['nroEstacionamento'],
          json['telefone'],
          json['valorHora'],
          endereco,
          horarios);
      estacionamentos.add(estacionamento);
    }
    return estacionamentos;
  }

Future<List<Estacionamento>> listarEstacionamentoBusca(String busca) async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    final Map<String, dynamic> buscarRuaMap = {
      'logradouro': busca
    };

    final String jsonBuscarRua = jsonEncode(buscarRuaMap);

     final Response response = await client.post(
        Uri.parse('${urlPadrao}estacionamento/estacionamentoRua'),
        headers: {"content-type": "application/json"},
        body: jsonBuscarRua);
    var estacionamentoJson = jsonDecode(response.body);
    final List<Estacionamento> estacionamentos = [];

    if (estacionamentoJson['result'] != ' ') {
    for (var json in estacionamentoJson['result']) {
      var endereco = await EnderecoService().buscarEndereco(json['endereco']);
      var horarios = await HorarioFuncionamentoService().listarHorarios(json['idEstacionamento']);
      final Estacionamento estacionamento = Estacionamento(
          json['idEstacionamento'],
          json['nomeEstacionamento'],
          json['CNPJ'],
          json['qtdTotalVagas'],
          json['qtdVagasDisponiveis'],
          json['nroEstacionamento'],
          json['telefone'],
          json['valorHora'],
          endereco,
          horarios);
      estacionamentos.add(estacionamento);
    }
    }
    return estacionamentos;
  }
}
