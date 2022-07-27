import 'package:estacionamento/components/ListaCaracteristicas.dart';
import 'package:estacionamento/models/Caracteristica.dart';
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

class CaracteristicaService {
  String urlPadrao = "http://estacionamento-pedepano.herokuapp.com/paraki/";

  Future<List<Caracteristica>> listarCaracteristicas(
      int idEstacionamento) async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    final response = await client.get(Uri.parse(
        '${urlPadrao}estacionamentoCaracteristica/listarCaracteristicasEstacionamento/' +
            idEstacionamento.toString()));
    final List<Caracteristica> caracteristicas = [];
    var caracteristicaJson = jsonDecode(response.body);

    for (var json in caracteristicaJson['result']) {
      final Caracteristica caracteristica = Caracteristica(
        idCaracteristica: json['idCaracteristica'],
        caracteristica: json['caracteristica'],
      );
      caracteristicas.add(caracteristica);
    }
    return caracteristicas;
  }

  Future<List<Caracteristica>> listarTodasCaracteristicas() async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    final response =
        await client.get(Uri.parse('${urlPadrao}caracteristica/listar'));
    final List<Caracteristica> caracteristicas = [];
    var caracteristicaJson = jsonDecode(response.body);

    for (var json in caracteristicaJson['result']) {
      final Caracteristica caracteristica = Caracteristica(
        idCaracteristica: json['idCaracteristica'],
        caracteristica: json['caracteristica'],
      );
      caracteristicas.add(caracteristica);
    }
    return caracteristicas;
  }
}
