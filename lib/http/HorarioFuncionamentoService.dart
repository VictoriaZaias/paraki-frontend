import 'package:estacionamento/models/HorarioFuncionamento.dart';
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

class HorarioFuncionamentoService{

  String urlPadrao = "http://estacionamento-pedepano.herokuapp.com/paraki/";

  Future<List<HorarioFuncionamento>> listarHorarios(int idEstacionamento) async {
  final Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );
  final response = await client.get(Uri.parse('${urlPadrao}horarioFuncionamento/buscar/'+idEstacionamento.toString()));
  final List<HorarioFuncionamento> horarios = [];
  var horarioJson = jsonDecode(response.body);
  for (var json in horarioJson['result']){
    final HorarioFuncionamento horarioFuncionamento = HorarioFuncionamento(
      json['idHorarioFuncionamento'],
      json['horarioInicio'],
      json['horarioFim'],
      json['diaSemana'],
      idEstacionamento: json['estacionamento'].toString()
    );
    horarios.add(horarioFuncionamento);
  }
  return horarios;
 }
}