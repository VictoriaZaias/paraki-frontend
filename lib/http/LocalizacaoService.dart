import 'package:estacionamento/models/Estacionamento.dart';
import 'package:estacionamento/models/Localizacao.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

class LocalizacaoService {
  String urlPadrao = "http://estacionamento-pedepano.herokuapp.com/paraki/";

  Future<Set<Marker>> pegarlocalizacoes() async {
    final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    final response =
        await client.get(Uri.parse('${urlPadrao}estacionamento/listarMapa'));
    //final List<Localizacao> localizacoes = [];
    Set<Marker> markers = Set();
    var localizacaoJson = jsonDecode(response.body);

    for (var json in localizacaoJson['result']) {
      final Localizacao localizacao = Localizacao(
        nomeEstacionamento: json['nomeEstacionamento'],
        endereco: json['endereco'],
        idEstacionamento: json['idEstacionamento']
      );
      List<Location> variousLocations = await locationFromAddress(localizacao.endereco);
      Marker marker = Marker(
        markerId: MarkerId("localizacao.idEstacionamento"),
        position:
            LatLng(variousLocations[0].latitude, variousLocations[0].longitude),
      );
      markers.add(marker);
      //print(localizacao);
      //localizacoes.add(localizacao);
    }
    return markers;
  }
}
