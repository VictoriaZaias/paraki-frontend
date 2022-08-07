import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final TextEditingController? controlador;
  final String rotulo;
  final double altura;
  final double largura;
  final Function()? onPressed;

  const Button({
    Key? key,
    this.controlador,
    required this.rotulo,
    this.altura = 30.0,
    this.largura = 200.0,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 35.0, 15.0, 5.0),
      child: SizedBox(
        width: largura,
        height: altura,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF411884)),
            foregroundColor: MaterialStateProperty.all<Color>(Color(0xFFEDE4E2)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            )),
          ),
          child: Text(rotulo),
        ),
      ),
    );
  }
}
