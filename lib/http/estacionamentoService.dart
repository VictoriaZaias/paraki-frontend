import 'package:estacionamento/http/EnderecoService.dart';
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

class EstacionamentoService {
  String urlPadrao = "http://estacionamento-pedepano.herokuapp.com/paraki/";

  String enderecoCompleto(Estacionamento estacionamento) {
    String enderecoCompleto;
    enderecoCompleto = estacionamento.endereco.logradouro +
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

  Future<List<Estacionamento>> listarEstacionamento(int idUsuario) async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    final response = await client.get(
        Uri.parse('${urlPadrao}estacionamento/listar/' + idUsuario.toString()));
    final List<Estacionamento> estacionamentos = [];
    var estacionamentoJson = jsonDecode(response.body);

    for (var json in estacionamentoJson['result']) {
      var endereco = await EnderecoService().buscarEndereco(json['endereco']);
      final Estacionamento estacionamento = Estacionamento(
        json['idEstacionamento'],
        json['nomeEstacionamento'],
        json['CNPJ'],
        json['qtdTotalVagas'],
        json['qtdVagasDisponiveis'],
        json['nroEstacionamento'],
        json['telefone'],
        json['valorHora'].toDouble(),
        endereco,
        isFavoritado: json['favorito'],
        hasCarregamentoEletrico: json['caracteristica'],
      );
      estacionamentos.add(estacionamento);
    }
    return estacionamentos;
  }

  Future<List<Estacionamento>> listarEstacionamentosDono(int idUsuario) async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    final response = await client.get(Uri.parse(
        '${urlPadrao}estacionamento/listarEstacionamentosDono/' +
            idUsuario.toString()));
    final List<Estacionamento> estacionamentos = [];
    var estacionamentoJson = jsonDecode(response.body);

    for (var json in estacionamentoJson['result']) {
      var endereco = await EnderecoService().buscarEndereco(json['endereco']);
      final Estacionamento estacionamento = Estacionamento(
        json['idEstacionamento'],
        json['nomeEstacionamento'],
        json['CNPJ'],
        json['qtdTotalVagas'],
        json['qtdVagasDisponiveis'],
        json['nroEstacionamento'],
        json['telefone'],
        json['valorHora'].toDouble(),
        endereco,
      );
      estacionamentos.add(estacionamento);
    }
    return estacionamentos;
  }

  Future<List<Estacionamento>> listarEstacionamentoBusca(String busca) async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    final Map<String, dynamic> buscarRuaMap = {'logradouro': busca};

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
        final Estacionamento estacionamento = Estacionamento(
          json['idEstacionamento'],
          json['nomeEstacionamento'],
          json['CNPJ'],
          json['qtdTotalVagas'],
          json['qtdVagasDisponiveis'],
          json['nroEstacionamento'],
          json['telefone'],
          json['valorHora'].toDouble(),
          endereco,
        );
        estacionamentos.add(estacionamento);
      }
    }
    return estacionamentos;
  }

  Future<List<Estacionamento>> listarEstacionamentoValidacao() async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    final response = await client.get(Uri.parse('${urlPadrao}estacionamento/'));
    final List<Estacionamento> estacionamentos = [];
    var estacionamentoJson = jsonDecode(response.body);

    for (var json in estacionamentoJson['result']) {
      var endereco = await EnderecoService().buscarEndereco(json['endereco']);
      final Estacionamento estacionamento = Estacionamento(
        json['idEstacionamento'],
        json['nomeEstacionamento'],
        json['CNPJ'],
        json['qtdTotalVagas'],
        json['qtdVagasDisponiveis'],
        json['nroEstacionamento'],
        json['telefone'],
        json['valorHora'].toDouble(),
        endereco,
      );
      estacionamentos.add(estacionamento);
    }
    return estacionamentos;
  }

  void cadastrarEstacionamento(
      Estacionamento estacionamento, idEndereco) async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    print("-------------------");
    print(estacionamento.horarios);
    print("-------------------");
    print(estacionamento.caracteristicas);
    final Map<String, dynamic> estacionamentoMap = {
      'cnpj': estacionamento.cnpj,
      'nomeEstacionamento': estacionamento.nomeEstacionamento,
      'qtdVagas': estacionamento.qtdTotalVagas,
      'idEndereco': idEndereco,
      'telefone': estacionamento.telefone,
      'valorHora': estacionamento.valorHora,
      'caracteristica': estacionamento.caracteristicas,
      'horario': estacionamento.horarios
    };

    //CaracteristicaService().cadastrarCaracteristica(estacionamento.caracteristicas!, estacionamento.idEstacionamento);
    print("-----------------");
    final String jsonEstacionamento = jsonEncode(estacionamentoMap);
    print(jsonEstacionamento);
    //await client.post(Uri.parse('${urlPadrao}estacionamento/cadastrar'),
    //headers: {"content-type": "application/json"}, body: jsonEstacionamento);
  }
}
