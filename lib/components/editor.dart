import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;
  final TextInputType? teclado;

  const Editor(
      {Key? key,
      this.controlador,
      this.rotulo,
      this.dica,
      this.icone,
      this.teclado})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: SizedBox(
        width: 300.0,
        height: 50.0,
        child: TextField(
          keyboardType: teclado,
          decoration: InputDecoration(
            labelText: rotulo,
            hintText: dica,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          ),
        ),
      ),
    );
  }
}
