import 'package:estacionamento/models/LoginResponseModel.dart';
import 'package:estacionamento/models/Usuario.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

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

class LoginService {
  String urlPadrao = "http://estacionamento-pedepano.herokuapp.com/paraki/";

  Future<Usuario> validarLogin(String cpf, String senha) async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );

    final Map<String, dynamic> usuarioMap = {
      'CPF': cpf,
      'senha': senha,
    };

    final String jsonUsuario = jsonEncode(usuarioMap);
    final Response response = await client.post(
      Uri.parse('${urlPadrao}usuario/login'),
      headers: {"content-type": "application/json"},
      body: jsonUsuario,
    );
/*
    if(response.statusCode == 200) {
      var jsonString = response.body;
      LoginResponseModel responseModel = loginResponseFromJson(jsonString);
      return responseModel.statusCode == 200 ? true: false;
    }
*/
    var json = jsonDecode(response.body);

    var usuario = Usuario(0, "", "", "", "", "");

    if (json['result'] != 'CPF ou senha inválidos!') {
      usuario = Usuario(
        json['result']['idUsuario'],
        json['result']['nomeUsuario'],
        json['result']['CPF'],
        json['result']['tipoUsuario'],
        json['result']['modeloCarro'],
        json['result']['senha'],
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('USER_ID', usuario.idUsuario);
    }
    return usuario;
  }
}
