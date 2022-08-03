import 'dart:async';
import 'package:estacionamento/screens/Login.dart';
import 'package:flutter/material.dart';

class Inicial extends StatefulWidget {
  const Inicial({Key? key}) : super(key: key);

  @override
  State<Inicial> createState() => _InicialState();
}

class _InicialState extends State<Inicial> {
  late Timer timer;
  int counter = 0;

  @override
  void initState() {
    /*
    timer = new Timer(const Duration(seconds: 4), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    });
    */
    timer = Timer.periodic(
        Duration(seconds: 1), (_) => setState(() => counter += 1));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
          child: _animationPk(),
          duration: const Duration(seconds: 4),
          /*
          transitionBuilder: (Widget child, Animation<double> animation) {
            return AnimatedSwitcher.defaultTransitionBuilder(child, animation);
          },*/
        ),
      ),
    );
  }

  Widget? _animationPk() {
    switch (counter) {
      case 0:
        return _renderParakiZero();
      case 1:
        return _renderParakiUm();
      case 2:
        return _renderParakiDois();
      case 3:
        return _renderParakiTres();
      default:
        dispose();
        return null;
    }
  }

  Widget _renderParakiZero() {
    return Image.asset(
      'assets/images/pk-0.png',
      scale: 2.5,
    );
  }

  Widget _renderParakiUm() {
    return Image.asset(
      'assets/images/pk-1.png',
      scale: 2.5,
    );
  }

  Widget _renderParakiDois() {
    return Image.asset(
      'assets/images/pk-2.png',
      scale: 2.5,
    );
  }

  Widget _renderParakiTres() {
    return Image.asset(
      'assets/images/pk-3.png',
      scale: 2.5,
    );
  }
}
