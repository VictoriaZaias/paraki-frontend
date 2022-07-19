import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final TextEditingController? controlador;
  final double padding;
  final double? tamanhoBotao;
  final IconData? simbolo;
  final double? tamanhoSimbolo;
  final Function()? onPressed;

  const ActionButton({
    Key? key,
    this.controlador,
    this.padding = 20.0,
    this.tamanhoBotao = 60.0,
    this.simbolo,
    this.tamanhoSimbolo = 25.0,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: SizedBox(
        width: tamanhoBotao,
        height: tamanhoBotao,
        child: FloatingActionButton(
          heroTag: null,
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
