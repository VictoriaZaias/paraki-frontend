import 'package:estacionamento/components/Button.dart';
import 'package:estacionamento/components/ContainerDados.dart';
import 'package:estacionamento/utils/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mercadopago_sdk/mercadopago_sdk.dart';
import '../components/TopoPadrao.dart';
import '../http/EstacionamentoService.dart';
import '../http/ReservaService.dart';
import '../models/Reserva.dart';
import 'AcaoBemSucedida.dart';

class Pagamento extends StatefulWidget {
  final Reserva reserva;

  const Pagamento({
    Key? key,
    required this.reserva,
  }) : super(key: key);

  @override
  State<Pagamento> createState() => _PagamentoState();
}

class _PagamentoState extends State<Pagamento> {
  @override
  void initState() {
    const channelMercadoPagoResposta =
        const MethodChannel("example.com/mercadoPagoResposta");
    channelMercadoPagoResposta.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'mercadoPagoOK':
          var idPago = call.arguments[0];
          var status = call.arguments[1];
          var statusDetails = call.arguments[2];
          mercadoPagoOK(idPago, status, statusDetails);

          ReservaService().cadastrarReserva(
            widget.reserva,
            widget.reserva.estacionamento!.idEstacionamento!,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AcaoBemSucedida("Reserva feita com sucesso!"),
            ),
          );
          break;
        case 'mercadoPagoError':
          var error = call.arguments[0];
          return mercadoPagoERROR(error);
      }
    });
    super.initState();
  }

  void mercadoPagoOK(idPago, status, statusDetails) {
    print("idPago $idPago");
    print("status $status");
    print("statusDetails $statusDetails");
  }

  void mercadoPagoERROR(error) {
    print("error $error");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopoPadrao(
        titulo: "Pagamento",
      ),
      body: Column(
        children: [
          ContainerDados(
            titulo: widget.reserva.estacionamento!.nomeEstacionamento,
            dados: [
              Text(EstacionamentoService()
                  .enderecoCompleto(widget.reserva.estacionamento!)),
            ],
          ),
          ContainerDados(
            titulo: "Reserva",
            dados: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Dia"),
                  Text(widget.reserva.dataReserva!),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Entrada"),
                  Text(widget.reserva.horarioEntrada!),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Saída"),
                  Text(widget.reserva.horarioSaida!),
                ],
              ),
            ],
          ),
          ContainerDados(
            titulo: "Total",
            dados: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("R\$ " + widget.reserva.valorTotal.toString()),
                ],
              )
            ],
          ),
          Button(
            rotulo: "Pagamento",
            onPressed: executarMercadoPago,
            /*
            () {
              ReservaService().cadastrarReserva(
                reserva,
                reserva.estacionamento!.idEstacionamento!,
              );
              executarMercadoPago();
            },
            */
            /*
            onPressed: ()  {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AcaoBemSucedida("Reserva feita com sucesso!"),
                ),
              );
            },
            */
          ),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>> montarPreferencia() async {
    var mp = MP(globals.mpClientID, globals.mpClientSecret);
    var preference = {
      "items": [
        {
          "title": "Reserva",
          "quantity": 1,
          "currency_id": "R\$",
          "unit_price": widget.reserva.valorTotal,
        }
      ],
      "payer": {
        "name": widget.reserva.usuario!.nomeUsuario,
        "email": "meuemail@email.com",
      },
      "payment_methods": {
        "excluded_payment_types": [
          {"id": "ticket"},
          {"id": "atm"},
        ]
      }
    };

    var result = await mp.createPreference(preference);
    return result;
  }

  Future<void> executarMercadoPago() async {
    montarPreferencia().then((result) {
      if (result != null) {
        var preferenceId = result['response']['id'];
        try {
          const channelMercadoPago =
              const MethodChannel("example.com/mercadoPago");
          final response =
              channelMercadoPago.invokeMethod('mercadoPago', <String, dynamic>{
            "publicKey": globals.mpTESTPublicKey,
            "preferenceId": preferenceId,
          });
          print(response);
        } on PlatformException catch (e) {
          print(e.message);
        }
      }
    });
  }
}
