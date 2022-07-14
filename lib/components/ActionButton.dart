import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final TextEditingController? controlador;
  final double? tamanhoBotao;
  final IconData? simbolo;
  final double? tamanhoSimbolo;
  final Function()? onPressed;

  const ActionButton({
    Key? key,
    this.controlador,
    this.tamanhoBotao = 60.0,
    this.simbolo,
    this.tamanhoSimbolo = 25.0,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: tamanhoBotao,
        height: tamanhoBotao,
        child: FloatingActionButton(
          onPressed: onPressed,
          child: Center(
            child: Icon(
              simbolo,
              size: tamanhoSimbolo,
            ),
          ),
        ),
      ),
    );
  }
}
