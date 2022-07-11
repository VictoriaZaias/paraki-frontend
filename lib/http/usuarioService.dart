/*import 'package:estacionamento/models/usuario.dart';
import 'package:http/http.dart' as http;
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

Future<List<Usuario>> findAll() async {
  final Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );
  final response = await client
      .get(Uri.parse('http://192.168.1.110:3000/paraki/usuario/listar'));
  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Usuario> usuarios = [];
  for (Map<String, dynamic> usuarioJson in decodedJson) {
    //final Map<String, dynamic> result = usuarioJson['result'];
    final Usuario usuario = Usuario(
      usuarioJson['result']['idUsuario'],
      usuarioJson['result']['nomeUsuario'],
      usuarioJson['result']['CPF'],
      usuarioJson['result']['tipoUsuario'],
      usuarioJson['result']['senha'],
      usuarioJson['result']['modeloCarro'],
    );
    print(usuario.cpf);
    usuarios.add(usuario);
  }

  if (response.statusCode == 200) {
    final List<dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson
        .map((dynamic json) => Usuario.fromJson(json))
        .toList();
  }
  throw HttpException(_getMessage(response.statusCode));

  return usuarios;
}*/
