import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final double? altura;
  final double? largura;
  final String? dica;
  final IconData? icone;
  final TextInputType? teclado;

  const Editor(
      {Key? key,
      this.controlador,
      this.rotulo,
      this.altura = 50.0,
      this.largura = 300.0,
      this.dica,
      this.icone,
      this.teclado})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: SizedBox(
        width: largura,
        height: altura,
        child: TextField(
          controller: controlador,
          keyboardType: teclado,
          decoration: InputDecoration(
            prefixIcon: icone != null ? Icon(icone) : null,
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
