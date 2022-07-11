/*import 'package:http/http.dart';
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

Future<List<HorarioFuncionamento>> findAll() async {
  final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response =
      await client.get('URL');
  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<HorarioFuncionamento> horarioFuncionamentos = [];
  for (Map<String, dynamic> horarioFuncionamentoJson in decodedJson) {
    final HorarioFuncionamento horarioFuncionamento = HorarioFuncionamento(
      horarioFuncionamentoJson['horarioInicio'],
      horarioFuncionamentoJson['horarioFim'],
      horarioFuncionamentoJson['diaSemana'],
      horarioFuncionamentoJson['estacionamento'],
    );
    horarioFuncionamentos.add(horarioFuncionamento);
  }
  return horarioFuncionamentos;
}*/