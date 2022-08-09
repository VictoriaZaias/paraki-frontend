import 'package:estacionamento/components/Button.dart';
import 'package:estacionamento/components/ContainerDados.dart';
import 'package:estacionamento/utils/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mercadopago_sdk/mercadopago_sdk.dart';
import '../components/TopoPadrao.dart';
import '../http/EstacionamentoService.dart';
import '../models/Reserva.dart';
import 'AcaoBemSucedida.dart';

class Pagamento extends StatelessWidget {
  final Reserva reserva;

  const Pagamento({
    Key? key,
    required this.reserva,
  }) : super(key: key);

  Future<Map<String, dynamic>> montarPreferencia() async {
    var mp = MP(globals.mpClientID, globals.mpClientSecret);
    var preference = {
      "items": [
        {
          "title": "Test Modified",
          "quantity": 1,
          "currency_id": "R\$",
          "unit_price": 20.4
        }
      ],
      "payer": {"name": "Martinho da vila", "email": "martinho@boobaloo.com"},
      "payment_methods": {
        "excluded_payment_types": [
          
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopoPadrao(
        titulo: "Pagamento",
      ),
      body: Column(
        children: [
          ContainerDados(
            titulo: reserva.estacionamento!.nomeEstacionamento,
            dados: [
              Text(EstacionamentoService()
                  .enderecoCompleto(reserva.estacionamento!)),
            ],
          ),
          ContainerDados(
            titulo: "Reserva",
            dados: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Dia"),
                  Text(reserva.dataReserva!),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Entrada"),
                  Text(reserva.horarioEntrada!),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Saída"),
                  Text(reserva.horarioSaida!),
                ],
              ),
            ],
          ),
          ContainerDados(
            titulo: "Total",
            dados: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [],
              )
            ],
          ),
          Button(
            rotulo: "Pagamento",
            onPressed: executarMercadoPago,
            /*
            onPressed: ()  {
              /*
              PaymentResult result =
                  await MercadoPagoMobileCheckout.startCheckout(
                "TEST-289dbf5a-95ae-4c1c-a067-f68578724676",
                "187874844-9eb0116d-1e1e-4606-aff2-d85a911e194a",
              );
              print(result.toString());
              */
/*              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AcaoBemSucedida("Reserva feita com sucesso!"),
                ),
              );*/
            },
            */
          ),
        ],
      ),
    );
  }
}
