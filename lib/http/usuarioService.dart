import 'package:estacionamento/models/Usuario.dart';
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

class UsuarioService {
  String urlPadrao = "http://estacionamento-pedepano.herokuapp.com/paraki/";

  Future<List<Usuario>> listarUsuario() async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    final response = await client.get(Uri.parse('${urlPadrao}usuario/listar'));
    final List<Usuario> usuarios = [];
    var usuarioJson = jsonDecode(response.body);
    for (var json in usuarioJson['result']) {
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

  void cadastrarUsuario(Usuario usuario) async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    final Map<String, dynamic> usuarioMap = {
      'nomeUsuario': usuario.nomeUsuario,
      'CPF': usuario.cpf,
      'senha': usuario.senha,
      'tipoUsuario': usuario.tipo,
      'modeloCarro': usuario.modeloCarro,
    };

    final String jsonUsuario = jsonEncode(usuarioMap);
    await client.post(Uri.parse('${urlPadrao}usuario/cadastrar'),
        headers: {"content-type": "application/json"}, body: jsonUsuario);
  }

  Future<Usuario> buscarUsuario(String CPF) async{
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );{
      final usuarioResponse = await client.get(Uri.parse('${urlPadrao}usuario/buscar/$CPF'));

      var jsonUsuario = jsonDecode(usuarioResponse.body);
      final Usuario usuario = Usuario(
        jsonUsuario['result']['idUsuario'],
        jsonUsuario['result']['nomeUsuario'],
        CPF,
        jsonUsuario['result']['tipoUsuario'],
        jsonUsuario['result']['modeloCarro'],
        jsonUsuario['result']['senha']

      );
  
    return usuario;
    }
  }

  Future<void> alterarPermissao(Usuario usuario) async {
   final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    String tipo = "";
    if(usuario.tipo == "Dono de estacionamento"){
        tipo = "Motorista";
    }else if(usuario.tipo == "Motorista"){
       tipo = "Dono de estacionamento";
    }

    final Map<String, dynamic> usuarioMap = {
      'idUsuario': usuario.idUsuario,
      'tipoUsuario': tipo
    };

    final String jsonUsuario = jsonEncode(usuarioMap);
    await client.post(Uri.parse('${urlPadrao}usuario/alterar'),
        headers: {"content-type": "application/json"}, body: jsonUsuario);
  }
}
