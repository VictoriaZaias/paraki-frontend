/*import 'package:estacionamento/models/estacionamento.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

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

Future<List<Estacionamento>> findAll() async {
  final Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response =
      await client.get('192.168.1.110:3000/paraki/estacionamento/listar');
  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Estacionamento> estacionamentos = [];
  for (Map<String, dynamic> estacionamentoJson in decodedJson) {
    final Estacionamento estacionamento = Estacionamento(
      estacionamentoJson['nomeEstacionamento'],
      estacionamentoJson['cnpjEstacionamento'],
      estacionamentoJson['qtdTotalVagasEstacionamento'],
      estacionamentoJson['enderecoEstacionamento'],
      estacionamentoJson['usuarioEstacionamento'],
      estacionamentoJson['telefoneEstacionamento'],
    );
    estacionamentos.add(estacionamento);
  }
  return estacionamentos;
}*/