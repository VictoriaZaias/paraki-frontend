import 'package:flutter/material.dart';

class ContainerDados extends StatelessWidget {
  final String titulo;
  final List<Widget> dados;

  const ContainerDados({
    Key? key,
    required this.titulo,
    required this.dados,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFB497F2),
            width: 1.5,
          ),
        ),
      ),
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Text(
            titulo,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: dados,
        ),
      ),
    );
  }
}
