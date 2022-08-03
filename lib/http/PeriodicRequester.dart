import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

class PeriodicRequester {
  static Stream<http.Response> getVagasDisponiveis(
      int idEstacionamento) async* {
    yield* Stream.periodic(Duration(seconds: 30), (_) {
      return get(Uri.parse(
          'https://estacionamento-pedepano.herokuapp.com/paraki/estacionamento/getVagas/' +
              idEstacionamento.toString()));
    }).asyncMap((event) async => await event);
  }
}
