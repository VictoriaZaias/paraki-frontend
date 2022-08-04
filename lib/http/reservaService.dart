import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'dart:convert';
import '../models/Reserva.dart';

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

class ReservaService {
  String urlPadrao = "http://eeserva-pedepano.herokuapp.com/paraki/";

  Future<List<Reserva>> listarReservas(int idUsuario) async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );

    final response = await client
        .get(Uri.parse('${urlPadrao}reserva/listar/' + idUsuario.toString()));
    final List<Reserva> reservas = [];
    var reservaJson = jsonDecode(response.body);

    for (var json in reservaJson['result']) {
      final Reserva reserva = Reserva(
          json['idReserva'],
          json['dataReserva'],
          json['horarioEntrada'],
          json['horarioSaida'],
          json['isUsuario'],
          json['isEstacionameneto']);
      reservas.add(reserva);
    }
    return reservas;
  }

  void cadastrarReserva(Reserva reserva, double valorHora) async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    final Map<String, dynamic> reservaMap = {
      'dataReserva': reserva.dataReserva,
      'horarioEntrada': reserva.horarioEntrada,
      'horarioSaida': reserva.horarioSaida,
      'usuario': reserva.idUsuario,
      'estacionamento': reserva.idEstacionamento,
      'precoHora': valorHora,
    };

    final String jsonReserva = jsonEncode(reservaMap);
    await client.post(Uri.parse('${urlPadrao}reserva/cadastrar'),
        headers: {"content-type": "application/json"}, body: jsonReserva);
  }
}
