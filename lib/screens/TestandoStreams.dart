import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

class PeriodicRequester extends StatelessWidget {
  Stream<http.Response> getVagasDisponiveis() async* {
    yield* Stream.periodic(Duration(seconds: 5), (_) {
      return get(Uri.parse(
          'https://estacionamento-pedepano.herokuapp.com/paraki/tests/getVagas'));
    }).asyncMap((event) async => await event);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<http.Response>(
      stream: getVagasDisponiveis(),
      builder: (context, snapshot) => snapshot.hasData
          ? Scaffold(
              body: Center(
                  child: Text(
                snapshot.data!.body,
              )),
            )
          : Scaffold(body: CircularProgressIndicator()),
    );
  }
}
