import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

class PeriodicRequester{
  static Stream<http.Response> getVagasDisponiveis() async* {
    yield* Stream.periodic(Duration(seconds: 5), (_) {
      return get(Uri.parse(
          'https://estacionamento-pedepano.herokuapp.com/paraki/tests/getVagas'));
    }).asyncMap((event) async => await event);
  }
}
