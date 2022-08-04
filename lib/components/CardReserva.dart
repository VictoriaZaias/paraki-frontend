import 'package:flutter/material.dart';

import '../models/Reserva.dart';

class CardReserva extends StatelessWidget {
  final Reserva reserva;

  const CardReserva({
    Key? key,
    required this.reserva,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        child: Card(
          child: ListTile(
            textColor: Colors.black,
            leading: Stack(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 100,
                    maxWidth: 100,
                  ), /*
                  child: Image.asset(
                    'assets/images/carro.png',
                    scale: 2,
                  ),*/
                ),
              ],
            ),
            title: Text("info"),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text("info"),
            ),
          ),
        ),
      ),
      onTap: () {},
    );
  }
}
