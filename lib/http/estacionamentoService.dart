import 'package:estacionamento/http/EnderecoService.dart';
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

class EstacionamentoService {
  String urlPadrao = "http://estacionamento-pedepano.herokuapp.com/paraki/";

  String enderecoCompleto(Estacionamento estacionamento) {
    String enderecoCompleto;
    enderecoCompleto = estacionamento.endereco!.logradouro +
        ", " +
        estacionamento.nroEstacionamento.toString() +
        " - " +
        estacionamento.endereco!.bairro +
        "\n" +
        estacionamento.endereco!.cidade +
        " - " +
        estacionamento.endereco!.unidadeFederativa +
        ", " +
        estacionamento.endereco!.cep;
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
      final Endereco endereco = Endereco(
        json['idEndereco'],
        json['bairro'],
        json['logradouro'],
        json['cidade'],
        json['uf'],
        json['cep'],
      );
      final Estacionamento estacionamento = Estacionamento(
        idEstacionamento: json['idEstacionamento'],
        nomeEstacionamento: json['nomeEstacionamento'],
        cnpj: json['CNPJ'],
        qtdTotalVagas: json['qtdTotalVagas'],
        qtdVagasDisponiveis: json['qtdVagasDisponiveis'],
        nroEstacionamento: json['nroEstacionamento'],
        telefone: json['telefone'],
        valorHora: json['valorHora'].toDouble(),
        endereco: endereco,
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
      final Endereco endereco = Endereco(
        json['idEndereco'],
        json['bairro'],
        json['logradouro'],
        json['cidade'],
        json['uf'],
        json['cep'],
      );
      final Estacionamento estacionamento = Estacionamento(
        idEstacionamento: json['idEstacionamento'],
        nomeEstacionamento: json['nomeEstacionamento'],
        cnpj: json['CNPJ'],
        qtdTotalVagas: json['qtdTotalVagas'],
        qtdVagasDisponiveis: json['qtdVagasDisponiveis'],
        nroEstacionamento: json['nroEstacionamento'],
        telefone: json['telefone'],
        valorHora: json['valorHora'].toDouble(),
        endereco: endereco,
        isFavoritado: json['favorito'],
        hasCarregamentoEletrico: json['caracteristica'],
      );
      estacionamentos.add(estacionamento);
    }
    return estacionamentos;
  }

  Future<List<Estacionamento>> listarEstacionamentoBusca(
      String buscaCidade, String buscaRua, int idUsuario) async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    final Map<String, dynamic> buscarCidadeRuaMap = {
      'cidade': buscaCidade,
      'rua': buscaRua,
    };

    final String jsonBuscarCidadeRua = jsonEncode(buscarCidadeRuaMap);

    final Response response = await client.post(
        Uri.parse('${urlPadrao}estacionamento/estacionamentoCidadeRua/' +
            idUsuario.toString()),
        headers: {"content-type": "application/json"},
        body: jsonBuscarCidadeRua);
    var estacionamentoJson = jsonDecode(response.body);
    final List<Estacionamento> estacionamentos = [];

    if (estacionamentoJson['result'] != ' ') {
      for (var json in estacionamentoJson['result']) {
        final Endereco endereco = Endereco(
          json['idEndereco'],
          json['bairro'],
          json['logradouro'],
          json['cidade'],
          json['uf'],
          json['cep'],
        );
        final Estacionamento estacionamento = Estacionamento(
          idEstacionamento: json['idEstacionamento'],
          nomeEstacionamento: json['nomeEstacionamento'],
          cnpj: json['CNPJ'],
          qtdTotalVagas: json['qtdTotalVagas'],
          qtdVagasDisponiveis: json['qtdVagasDisponiveis'],
          nroEstacionamento: json['nroEstacionamento'],
          telefone: json['telefone'],
          valorHora: json['valorHora'].toDouble(),
          endereco: endereco,
          isFavoritado: json['favorito'],
          hasCarregamentoEletrico: json['eletrico'],
        );
        estacionamentos.add(estacionamento);
      }
    }
    return estacionamentos;
  }

  void cadastrarEstacionamento(
      Estacionamento estacionamento, idEndereco, idUsuario) async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    int i = 0;
    final Map<String, dynamic> caracteristicaMap = {};
    for (var e in estacionamento.caracteristicas!) {
      caracteristicaMap.putIfAbsent(i.toString(), () => e.idCaracteristica);
      i++;
    }

    final Map<String, dynamic> horarioSemanalMap = {};
    final Map<String, dynamic> horarioSabMap = {};
    final Map<String, dynamic> horarioDomMap = {};
    for (var e in estacionamento.horarios!) {
      if (e.diaSemana == "semanal") {
        horarioSemanalMap.putIfAbsent("horarioInicio", () => e.horarioInicio);
        horarioSemanalMap.putIfAbsent("horarioFim", () => e.horarioFim);
      } else if (e.diaSemana == "Dom") {
        horarioDomMap.putIfAbsent("horarioInicio", () => e.horarioInicio);
        horarioDomMap.putIfAbsent("horarioFim", () => e.horarioFim);
      } else if (e.diaSemana == "Sab") {
        horarioSabMap.putIfAbsent("horarioInicio", () => e.horarioInicio);
        horarioSabMap.putIfAbsent("horarioFim", () => e.horarioFim);
      }
    }

    final Map<String, dynamic> estacionamentoMap = {
      'cnpj': estacionamento.cnpj,
      'nomeEstacionamento': estacionamento.nomeEstacionamento,
      'qtdVagas': estacionamento.qtdTotalVagas,
      'idEndereco': idEndereco,
      'telefone': estacionamento.telefone,
      'valorHora': estacionamento.valorHora,
      'caracteristica': caracteristicaMap,
      'nroEstacionamento': estacionamento.nroEstacionamento,
      'usuario': idUsuario,
      'semanal': horarioSemanalMap,
      'dom': horarioDomMap,
      'sab': horarioSabMap
    };

    final String jsonEstacionamento = jsonEncode(estacionamentoMap);
    await client.post(Uri.parse('${urlPadrao}estacionamento/cadastrar'),
        headers: {"content-type": "application/json"},
        body: jsonEstacionamento);
  }

  Future<bool> validarCNPJ(String cnpj) async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    final respostaCNPJ = await client
        .get(Uri.parse('${urlPadrao}estacionamento/validarCNPJ/$cnpj'));
    var jsonValidar = jsonDecode(respostaCNPJ.body);
    final String valido = jsonValidar['result'];
    if (valido == "valido") {
      return true;
    }
    return false;
  }
}
