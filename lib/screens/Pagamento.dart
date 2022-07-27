import 'package:flutter/material.dart';
import '../components/TopoPadrao.dart';

class Pagamento extends StatelessWidget {
  const Pagamento({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopoPadrao(
        titulo: "Pagamento",
      ),
    );
  }
}
