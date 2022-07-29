import 'package:estacionamento/models/Reserva.dart';
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

class ReservaService{
  String urlPadrao = "http://estacionamento-pedepano.herokuapp.com/paraki/";

  void cadastrarReserva(Reserva reserva, double valorHora) async{
   final Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );
   final Map<String, dynamic> reservaMap= {
        'dataReserva': reserva.dataReserva,
        'horarioEntrada': reserva.horarioEntrada,
        'horarioSaida': reserva.horarioSaida,
        'usuario' : reserva.idUsuario,
        'estacionamento' : reserva.idEstacionamento,
        'precoHora': valorHora,
   };
    
   final String jsonReserva = jsonEncode(reservaMap);
   await client.post(Uri.parse('${urlPadrao}reserva/cadastrar'), headers: {"content-type":"application/json"}, body: jsonReserva); 

  }
}