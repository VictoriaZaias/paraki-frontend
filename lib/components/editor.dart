import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? Function(String?)? validacao;
  final String? rotulo;
  final double? altura;
  final double? largura;
  final String? dica;
  final IconData? icone;
  final TextInputType? teclado;
  final bool? enabled;
  final Function(String)? onSubmitted;
  final bool senha;
  final String? textoErro;
  final Function(String)? onChanged;
  final Function()? onTap;

  const Editor({
    Key? key,
    this.controlador,
    this.validacao,
    this.rotulo,
    this.altura = 50.0,
    this.largura = 300.0,
    this.dica,
    this.icone,
    this.teclado,
    this.enabled,
    this.onSubmitted,
    this.onChanged,
    this.onTap,
    this.senha = false,
    this.textoErro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: largura,
        //height: altura,
        child: TextFormField(
          enabled: enabled,
          onChanged: onChanged,
          onTap: onTap,
          onFieldSubmitted: onSubmitted,
          obscureText: senha,
          controller: controlador,
          validator: validacao,
          keyboardType: teclado,
          decoration: InputDecoration(
            prefixIcon: icone != null ? Icon(icone) : null,
            labelText: rotulo,
            hintText: dica,
            helperText: textoErro,
            contentPadding:
                EdgeInsets.symmetric(vertical: 0, horizontal: 15.0),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
    );
  }
}
