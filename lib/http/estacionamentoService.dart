import 'package:estacionamento/models/estacionamento.dart';
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

Future<List<Estacionamento>> listarEstacionamento() async {
  final Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );
  final response = await client.get(Uri.parse('http://localhost:3000/paraki/estacionamento/listar'));
  final List<Estacionamento> estacionamentos = [];
  var estacionamentoJson = jsonDecode(response.body);
  for (var json in estacionamentoJson['result']){
     final Estacionamento estacionamento = Estacionamento(
      json['idEstacionamento'],
      json['nomeEstacionamento'],
      json['CNPJ'],
      json['telefone'],
      json['qtdTotalVagas'],
      //json['nroEstacionamento'],
      //json['endereco'],
      json['usuario'],
      
    );
    estacionamentos.add(estacionamento);
  }  
  return estacionamentos;
}
