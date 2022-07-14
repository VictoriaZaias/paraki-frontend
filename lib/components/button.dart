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
    this.altura = 150.0,
    this.largura = 30.0,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
      child: SizedBox(
        width: altura,
        height: largura,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
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
