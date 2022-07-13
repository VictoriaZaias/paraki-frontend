import 'package:flutter/material.dart';

// talvez deixar abstrata e criar os filhos como o arow_back q irá repetir muitas vezes...
/*
ActionButton(
  tamanho: 70.0,
  simbolo: const Icon(Icons.arrow_back),
  onPressed: () {},
)
*/
class ActionButton extends StatelessWidget {
  final TextEditingController? controlador;
  final double? tamanhoBotao;
  final IconData? simbolo;
  final double? tamanhoSimbolo;
  final Function()? onPressed;

  const ActionButton({
    Key? key,
    this.controlador,
    this.tamanhoBotao,
    this.simbolo,
    this.tamanhoSimbolo,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: tamanhoBotao,
        height: tamanhoBotao,
        child: FloatingActionButton(
          onPressed: onPressed,
          child: Icon(
            simbolo,
            size: 25.0,
          ),
        ),
      ),
    );
  }
}
