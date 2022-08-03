import 'package:estacionamento/components/ListaCaracteristicas.dart';
import 'package:flutter/material.dart';
import '../models/Caracteristica.dart';

class CheckboxCaracteristica extends StatefulWidget {
  final Caracteristica caracteristica;
  final List<Caracteristica> isChecked;

  const CheckboxCaracteristica({
    Key? key,
    required this.caracteristica,
    required this.isChecked,
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
      height: 45.0,
      child: CheckboxListTile(
        title: Text(widget.caracteristica.caracteristica),
        controlAffinity: ListTileControlAffinity.leading,
        value: checkbox_valor,
        onChanged: (bool? value) {
          setState(() {
            checkbox_valor = value!;
            if (value != null && value) {
              widget.isChecked.add(widget.caracteristica);
            } else {
              widget.isChecked.remove(widget.caracteristica);
            }
          });
        },
      ),
    );
  }
}
