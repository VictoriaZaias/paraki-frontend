import 'package:estacionamento/models/Estacionamento.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'dart:convert';
import '../models/Endereco.dart';
import '../models/Reserva.dart';
import '../models/Usuario.dart';

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
  String urlPadrao = "http://estacionamento-pedepano.herokuapp.com/paraki/";

  Future<List<Reserva>> listarReservas(int idUsuario) async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );

    final response = await client.get(Uri.parse(
        '${urlPadrao}reserva/listarReservasUsuario/' + idUsuario.toString()));
    final List<Reserva> reservas = [];
    var reservaJson = jsonDecode(response.body);

    for (var json in reservaJson['result']) {
      final Endereco endereco = Endereco(
        json['idEndereco'],
        json['bairro'],
        json['logradouro'],
        json['cidade'],
        json['uf'],
        json['cep'],
      );
      print('------------------');
      print(endereco);
      final Estacionamento estacionamento = Estacionamento(
        idEstacionamento: json['idEstacionamento'],
        nomeEstacionamento: json['nomeEstacionamento'],
        nroEstacionamento: json['nroEstacionamento'],
        telefone: json['telefone'],
        valorHora: json['valorTotal'].toDouble(),
        endereco: endereco,
      );
      print('------------------');
      print(estacionamento);
      final Reserva reserva = Reserva(
        json['idReserva'],
        json['dataReserva'],
        json['horarioEntrada'],
        json['horarioSaida'],
        estacionamento: estacionamento,
        vaga: json['nomeVaga'],
        valorTotal: json['valorTotal'].toDouble(),
      );
      print('------------------');
      print(reserva);
      reservas.add(reserva);
    }
    return reservas;
  }

  Future<List<Reserva>> listarReservasEstacionamento(
      int idEstacionamento) async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );

    final response = await client.get(Uri.parse(
        '${urlPadrao}estacionamento/listarReservas/' +
            idEstacionamento.toString()));
    final List<Reserva> reservas = [];
    var reservaJson = jsonDecode(response.body);

    for (var json in reservaJson['result']) {
      final Usuario usuario = Usuario(
        json['nomeUsuario'],
        json['cpf'],
        json['tipoUsuario'],
        json['modeloCarro'],
        json['senha'],
        idUsuario: json['idUsuario'],
      );
      print('------------------');
      print(usuario);
      final Reserva reserva = Reserva(
        json['idReserva'],
        json['dataReserva'],
        json['horarioEntrada'],
        json['horarioSaida'],
        usuario: usuario,
        vaga: json['vaga'],
        valorTotal: json['valorTotal'].toDouble(),
      );
      print('------------------');
      print(reserva);
      reservas.add(reserva);
    }
    return reservas;
  }

  void cadastrarReserva(
      Reserva reserva, int idEstacionamento) async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    final Map<String, dynamic> reservaMap = {
      'dataReserva': reserva.dataReserva,
      'horarioEntrada': reserva.horarioEntrada,
      'horarioSaida': reserva.horarioSaida,
      'usuario': reserva.usuario!.idUsuario,
      'estacionamento': idEstacionamento,
      'valorTotal': reserva.valorTotal,
    };

    final String jsonReserva = jsonEncode(reservaMap);
    await client.post(Uri.parse('${urlPadrao}reserva/cadastrar'),
        headers: {"content-type": "application/json"}, body: jsonReserva);
  }
}
