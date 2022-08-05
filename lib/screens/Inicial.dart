import 'dart:async';
import 'package:estacionamento/screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Usuario.dart';
import 'Admin/PrincipalAdmin.dart';
import 'Dono/PrincipalDono.dart';
import 'PrincipalUsuario.dart';

class Inicial extends StatefulWidget {
  const Inicial({Key? key}) : super(key: key);

  @override
  State<Inicial> createState() => _InicialState();
}

class _InicialState extends State<Inicial> with SingleTickerProviderStateMixin {
  late SharedPreferences logindata;
  late bool newuser;

  static List _images = <Image>[
    Image.asset(
      'assets/images/pk-0.png',
      scale: 2.5,
    ),
    Image.asset(
      'assets/images/pk-1.png',
      scale: 2.5,
    ),
    Image.asset(
      'assets/images/pk-2.png',
      scale: 2.5,
    ),
    Image.asset(
      'assets/images/pk-3.png',
      scale: 2.5,
    ),
  ];

  Timer? timer;
  int index = 0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (index < _images.length - 1) {
        setState(() {
          index++;
        });
      }
      if (index == _images.length - 1) {
        timer.cancel();
        Future.delayed(const Duration(seconds: 1), () {
          check_if_already_login();
        });
      }
    });
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Container(
            key: ValueKey(_images[index]),
            child: _images[index],
          ),
        ),
      ),
    );
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    if (newuser == false) {
      Usuario usuario = Usuario(
        logindata.getString('username')!,
        logindata.getString('cpf')!,
        logindata.getString('tipo_user')!,
        logindata.getString('modelo_carro')!,
        logindata.getString('senha_user')!,
        idUsuario: logindata.getInt('id_user')!,
      );
      if (usuario.tipo == "Motorista") {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PrincipalUsuario(user: usuario)),
        );
      } else if (usuario.tipo == "Administrador") {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PrincipalAdmin()),
        );
      } else if (usuario.tipo == "Dono de estacionamento") {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PrincipalDono(user: usuario)),
        );
      }
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }
}
