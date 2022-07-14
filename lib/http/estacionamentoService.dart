import 'package:estacionamento/models/estacionamentoEspecifico.dart';
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

Future<List<estacionamentoEspecifico>> listarEstacionamento() async {
  final Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );
  final response = await client.get(Uri.parse('http://192.168.1.170:3000/paraki/estacionamento/listar'));
  final List<estacionamentoEspecifico> estacionamentos = [];
  var estacionamentoJson = jsonDecode(response.body);
  for (var json in estacionamentoJson['result']){
     final estacionamentoEspecifico estacionamento = estacionamentoEspecifico(
      json['idEstacionamento'],
      json['nomeEstacionamento'],
      //json['logradouro'],
      //json['nroEstacionamento'],
      //json['precoHora'],
      json['qtdTotalVagas'],
    );
    estacionamentos.add(estacionamento);
  }  
  return estacionamentos;
}

