import 'package:estacionamento/components/ListaReservas.dart';
import 'package:estacionamento/components/TopoPadrao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/Usuario.dart';

class ReservasMotorista extends StatefulWidget {
  final Usuario user;

  const ReservasMotorista({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ReservasMotorista> createState() => _ReservasMotoristaState();
}

class _ReservasMotoristaState extends State<ReservasMotorista> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopoPadrao(
        titulo: "Minhas reservas",
      ),
      body: Column(
        children: [
          ListaReservas(
            user: widget.user,
          ),
        ],
      ),
    );
  }
}
