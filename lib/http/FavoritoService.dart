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
    final response = await client
        .get(Uri.parse('${urlPadrao}favorito/listar/' + idUsuario.toString()));
    final List<Estacionamento> estacionamentos = [];
    var favoritoJson = jsonDecode(response.body);

    for (var json in favoritoJson['result']) {
      var endereco = await EnderecoService().buscarEndereco(json['endereco']);
      var horarios = await HorarioFuncionamentoService()
          .listarHorarios(json['idEstacionamento']);
      var caracteristicas = await CaracteristicaService()
          .listarCaracteristicas(json['idEstacionamento']);
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
        horarios,
        caracteristicas,
      );
      estacionamentos.add(estacionamento);
    }
    return estacionamentos;
  }
}
