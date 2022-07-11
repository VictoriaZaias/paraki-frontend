import 'package:flutter/material.dart';
import '../components/action_button.dart';

class PrincipalMotorista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ActionButton(
                tamanho: 70.0,
                simbolo: const Icon(Icons.person),
                onPressed: () {},
              ),
              ActionButton(
                tamanho: 70.0,
                simbolo: const Icon(Icons.star),
                onPressed: () {},
              ),
              ActionButton(
                tamanho: 70.0,
                simbolo: const Icon(Icons.manage_search),
                onPressed: () {},
              ),
            ],
          ),
          preferredSize: Size.fromHeight(50.0),
        ),
      ),
      body: const Center(
        child: Text('FINJA QUE AQUI TÁ PRONTO :)))'),
      ),
    );
  }
}
