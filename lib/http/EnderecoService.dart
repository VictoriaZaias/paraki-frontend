import 'package:estacionamento/models/Endereco.dart';
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

class EnderecoService {
  String urlPadrao = "http://estacionamento-pedepano.herokuapp.com/paraki/";

  Future<Endereco> buscarEndereco(int idEndereco) async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );{
      final enderecoResponse = await client.get(Uri.parse(
          '${urlPadrao}endereco/buscar/' + idEndereco.toString()));

      var jsonEndereco = jsonDecode(enderecoResponse.body);
      final Endereco endereco = Endereco(
        jsonEndereco['result']['idEndereco'],
        jsonEndereco['result']['bairro'],
        jsonEndereco['result']['logradouro'],
        jsonEndereco['result']['cidade'],
        jsonEndereco['result']['uf'],
        jsonEndereco['result']['cep'],
      );
      return endereco;
      }
  }

  Future<Endereco> buscarPorCEP(String cep) async{
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );{
      final enderecoResponse = await client.get(Uri.parse("http://viacep.com.br/ws/$cep/json/"));

      var jsonEndereco = jsonDecode(enderecoResponse.body);
      final Endereco endereco = Endereco(
        1,
        jsonEndereco['bairro'],
        jsonEndereco['logradouro'],
        jsonEndereco['localidade'],
        jsonEndereco['uf'],
        cep,
      );
  
    return endereco;
    }
  }

  void cadastrarEndereco(Endereco endereco) async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    final Map<String, dynamic> enderecoMap = {
      'logradouro': endereco.logradouro,
      'cidade': endereco.cidade,
      'uf': endereco.unidadeFederativa,
      'bairro': endereco.bairro,
      'cep': endereco.cep,
    };

    final String jsonEndereco = jsonEncode(enderecoMap);
    await client.post(Uri.parse('${urlPadrao}endereco/cadastrar'),
        headers: {"content-type": "application/json"}, body: jsonEndereco);
  }

  Future<int> buscarIdCEP(String cep) async{
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );{
      final enderecoResponse = await client.get(Uri.parse('${urlPadrao}endereco/verificaEndereco/$cep'));

      var jsonEndereco = jsonDecode(enderecoResponse.body);
      final int idEndereco = jsonEndereco['result']['idEndereco'];
       return idEndereco;
    }
  }
}
