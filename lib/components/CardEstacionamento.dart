import 'package:flutter/material.dart';

class CardEstacionamento extends StatelessWidget {
  final String nomeEstacionamento;
  final String quantidadeTotalVagas;

  const CardEstacionamento({
    Key? key,
    required this.nomeEstacionamento,
    required this.quantidadeTotalVagas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.circle),
        title: Text(nomeEstacionamento),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(quantidadeTotalVagas),
            //Text("Lodradouro, nº"),
            //Text("Preço por hora"),
          ],
        ),
      ),
    );
  }
}
