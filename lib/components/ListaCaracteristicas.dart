import 'package:estacionamento/components/CheckboxCaracteristica.dart';
import 'package:flutter/material.dart';

class ListaCaracteristicas extends StatefulWidget {
  const ListaCaracteristicas({Key? key}) : super(key: key);

  @override
  State<ListaCaracteristicas> createState() => _ListaCaracteristicasState();
}

class _ListaCaracteristicasState extends State<ListaCaracteristicas> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckboxCaracteristica(
          caracteristica: "Vagas cobertas",
        ),
        CheckboxCaracteristica(
          caracteristica: "Iluminação nas vagas",
        ),
        CheckboxCaracteristica(
          caracteristica: "Estacione e leve a chave",
        ),
      ],
    );
  }
}
