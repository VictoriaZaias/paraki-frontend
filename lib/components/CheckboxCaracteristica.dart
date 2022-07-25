import 'package:estacionamento/components/ListaCaracteristicas.dart';
import 'package:flutter/material.dart';

import '../models/Caracteristica.dart';

class CheckboxCaracteristica extends StatefulWidget {
  final Caracteristica caracteristica;

  const CheckboxCaracteristica({
    Key? key,
    required this.caracteristica,
  }) : super(key: key);

  @override
  State<CheckboxCaracteristica> createState() => _CheckboxCaracteristicaState();
}

class _CheckboxCaracteristicaState extends State<CheckboxCaracteristica> {
  bool checkbox_valor = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325.0,
      height: 50.0,
      child: Row(
        children: [
          Checkbox(
            value: checkbox_valor,
            onChanged: (bool? value) {
              setState(() {
                checkbox_valor = value!;
              });
            },
          ),
          Text(widget.caracteristica.caracteristica),
        ],
      ),
    );
  }
}
