import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import '../models/Estacionamento.dart';
import '../models/Favorito.dart';
import 'dart:convert';

import 'CaracteristicaService.dart';
import 'FavoritoService.dart';
import 'EnderecoService.dart';
import 'HorarioFuncionamentoService.dart';

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

class FavoritoService {
  String urlPadrao = "http://estacionamento-pedepano.herokuapp.com/paraki/";

  void excluirFavorito(Favorito favorito) async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    final Map<String, dynamic> favoritoMap = {
      'estacionamento': favorito.idEstacionamento,
    };

    final String jsonUsuario = jsonEncode(favoritoMap);
    await client.delete(
        Uri.parse(
            '${urlPadrao}/favorito/excluir/' + favorito.idUsuario.toString()),
        headers: {"content-type": "application/json"},
        body: jsonUsuario);
  }

  void cadastrarFavorito(Favorito favorito) async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    final Map<String, dynamic> usuarioMap = {
      'usuario': favorito.idUsuario,
      'estacionamento': favorito.idEstacionamento,
    };

    final String jsonUsuario = jsonEncode(usuarioMap);
    await client.post(Uri.parse('${urlPadrao}/favorito/cadastrar'),
        headers: {"content-type": "application/json"}, body: jsonUsuario);
  }

  Future<List<Estacionamento>> listarEstacionamentosFavoritados(
      int idUsuario) async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    final response = await client.get(Uri.parse(
        '${urlPadrao}estacionamento/listarFavoritosUsuario/' +
            idUsuario.toString()));
    final List<Estacionamento> estacionamentos = [];
    var favoritoJson = jsonDecode(response.body);

    for (var json in favoritoJson['result']) {
      var endereco = await EnderecoService().buscarEndereco(json['endereco']);
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
}
