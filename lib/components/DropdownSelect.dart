import 'package:flutter/material.dart';

class DropdownSelect<T> extends StatelessWidget {
  final String dica;
  final double? altura;
  final double? largura;
  final double borda;
  final List<T> opcoes;
  final T? valor;
  final String Function(T) getRotulo;
  final void Function(T?)? onChanged;

  DropdownSelect({
    this.dica = 'Selecione uma opção',
    this.altura = 50.0,
    this.largura = 300.0,
    this.borda = 20.0,
    this.opcoes = const [],
    this.valor,
    required this.getRotulo,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: largura,
        height: altura,
        child: FormField<T>(
          builder: (FormFieldState<T> state) {
            return InputDecorator(
              decoration: InputDecoration(
                labelText: dica,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(borda),
                ),
              ),
              isEmpty: valor == null || valor == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<T>(
                  value: valor,
                  //isDense: true,
                  onChanged: onChanged,
                  items: opcoes.map((T valor) {
                    return DropdownMenuItem<T>(
                      value: valor,
                      child: Text(getRotulo(valor)),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
