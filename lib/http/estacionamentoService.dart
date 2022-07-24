import 'package:estacionamento/models/Endereco.dart';
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
      final enderecoResponse = await client.get(Uri.parse(
          '${urlPadrao}endereco/buscar/' + json['endereco'].toString()));
      var jsonEndereco = jsonDecode(enderecoResponse.body);
      final Endereco endereco = Endereco(
        jsonEndereco['result']['idEndereco'],
        jsonEndereco['result']['bairro'],
        jsonEndereco['result']['logradouro'],
        jsonEndereco['result']['tipoLogradouro'],
        jsonEndereco['result']['cidade'],
        jsonEndereco['result']['uf'],
        jsonEndereco['result']['cep'],
      );
      final Estacionamento estacionamento = Estacionamento(
          json['idEstacionamento'],
          json['nomeEstacionamento'],
          json['CNPJ'],
          json['qtdTotalVagas'],
          json['nroEstacionamento'],
          json['telefone'],
          json['valorHora'],
          endereco);
      estacionamentos.add(estacionamento);
    }
    return estacionamentos;
  }
}
