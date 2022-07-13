import 'package:flutter/material.dart';

class CampoTipoCarro extends StatefulWidget {
  const CampoTipoCarro({Key? key}) : super(key: key);

  @override
  State<CampoTipoCarro> createState() => _CampoTipoCarroState();
}

class _CampoTipoCarroState extends State<CampoTipoCarro> {
  final listaTiposCarros = ["Combustão", "Elétrico", "Combustão e elétrico"];
  String? dropdownValue;
  String dica = "Modelo do(s) carro(s)";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFEDE4E2),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        width: 300.0,
        height: 53.0,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint: Text(dica),
            value: dropdownValue,
            elevation: 16,
            dropdownColor: Color(0xFFEDE4E2),
            items: listaTiposCarros.map((String value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
          ),
        ),
      ),
    );
  }
}
