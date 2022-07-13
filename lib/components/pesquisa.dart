import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final TextEditingController? controlador;
  final String rotulo;
  final Function()? onPressed;

  const Button({
    Key? key,
    this.controlador,
    required this.rotulo,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: SizedBox(
        width: 150.0,
        height: 30.0,
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
