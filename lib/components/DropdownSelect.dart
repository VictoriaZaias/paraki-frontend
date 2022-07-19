import 'package:flutter/material.dart';

class DropdownSelect<T> extends StatelessWidget {
  final String dica;
  final List<T> opcoes;
  final T? valor;
  final String Function(T) getRotulo;
  final void Function(T?)? onChanged;

  DropdownSelect({
    this.dica = 'Selecione uma opção',
    this.opcoes = const [],
    required this.getRotulo,
    this.valor,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: SizedBox(
        width: 300.0,
        height: 50.0,
        child: FormField<T>(
          builder: (FormFieldState<T> state) {
            return InputDecorator(
              decoration: InputDecoration(
                labelText: dica,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              isEmpty: valor == null || valor == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<T>(
                  value: valor,
                  isDense: true,
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
