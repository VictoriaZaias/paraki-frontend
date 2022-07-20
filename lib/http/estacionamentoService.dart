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

Future<List<Estacionamento>> listarEstacionamento() async {
  final Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );
  final response = await client.get(Uri.parse('http://172.25.239.100:3000/paraki/estacionamento/listar'));
  final List<Estacionamento> estacionamentos = [];
  var estacionamentoJson = jsonDecode(response.body);
  for (var json in estacionamentoJson['result']){
    //print('AAA*/*/*/*/');
    //final enderecoResponse = await client.get(Uri.parse('http://192.168.1.113:3000/paraki/endereco/buscar/'+json['endereco'].toString()));
    //var enderecoJson = jsonDecode(enderecoResponse.body);
    /*final Endereco endereco = Endereco(
      enderecoJson['idEndereco'],
      enderecoJson['bairro'],
      enderecoJson['logradouro'],
      enderecoJson['tipoLogradouro'],
      enderecoJson['cidade'],
      enderecoJson['uf'],
      enderecoJson['cep'],
      );*/
     final Estacionamento estacionamento = Estacionamento(
      json['idEstacionamento'],
      json['nomeEstacionamento'],
      json['CNPJ'],
      json['qtdTotalVagas'],
      json['nroEstacionamento'],
      json['telefone'],
      json['valorHora']
      //endereco 
    );
    //print("----AAAAA----");
    //print(estacionamento);
    estacionamentos.add(estacionamento);
  }
  return estacionamentos;
}

