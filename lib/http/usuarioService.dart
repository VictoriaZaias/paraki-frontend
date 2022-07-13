import 'package:estacionamento/models/usuario.dart';
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

Future<List<Usuario>> listarUsuario() async {
  final Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );
  final response = await client.get(Uri.parse('http://localhost:3000/paraki/usuario/listar'));
 // final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Usuario> usuarios = [];
  var usuarioJson = jsonDecode(response.body);
    //final Map<String, dynamic> result = usuarioJson['result'];
  for (var json in usuarioJson['result']){
     final Usuario usuario = Usuario(
      json['idUsuario'],
      json['nomeUsuario'],
      json['CPF'],
      json['tipoUsuario'],
      json['modeloCarro'],
      json['senha'],
      
    );
    usuarios.add(usuario);
  }  
  return usuarios;
}
