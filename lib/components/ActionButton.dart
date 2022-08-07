import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final TextEditingController? controlador;
  final double padding;
  final double? tamanhoBotao;
  final IconData? simbolo;
  final String? dica;
  final double? tamanhoSimbolo;
  final Color? corSimbolo;
  final Function()? onPressed;

  const ActionButton({
    Key? key,
    this.controlador,
    this.padding = 20.0,
    this.tamanhoBotao = 60.0,
    this.simbolo,
    this.dica,
    this.tamanhoSimbolo = 25.0,
    this.corSimbolo,
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
          foregroundColor: corSimbolo,
          onPressed: onPressed,
          child: Center(
            child: Icon(
              simbolo,
              size: tamanhoSimbolo,
            ),
          ),
          tooltip: dica,
        ),
      ),
    );
  }
}
