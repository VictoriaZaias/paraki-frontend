import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'dart:convert';

import '../models/EstacionamentoEspecifico.dart';

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

Future<List<EstacionamentoEspecifico>> listarEstacionamento() async {
  final Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );
  final response = await client.get(Uri.parse('http://192.168.1.105:3000/paraki/Estacionamento/listar'));
  final List<EstacionamentoEspecifico> Estacionamentos = [];
  var EstacionamentoJson = jsonDecode(response.body);
  for (var json in EstacionamentoJson['result']){
     final EstacionamentoEspecifico Estacionamento = EstacionamentoEspecifico(
      json['idEstacionamento'],
      json['nomeEstacionamento'],
      //json['logradouro'],
      //json['nroEstacionamento'],
      //json['precoHora'],
      json['qtdTotalVagas'],
    );
    Estacionamentos.add(Estacionamento);
  }
  return Estacionamentos;
}

