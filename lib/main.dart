import 'dart:async';
import 'package:estacionamento/screens/Login.dart';
import 'package:estacionamento/screens/Pagamento.dart';
import 'package:estacionamento/screens/PrincipalAdmin.dart';
import 'package:estacionamento/screens/PrincipalUsuario.dart';
import 'package:flutter/material.dart';
import 'http/Shared.dart';
import 'screens/Login.dart';
import 'theme/style_one.dart';

main() {
  runApp(const ParakiApp());
}

class ParakiApp extends StatefulWidget {
  const ParakiApp({Key? key}) : super(key: key);

  @override
  State<ParakiApp> createState() => _ParakiAppState();
}

class _ParakiAppState extends State<ParakiApp> {
  /*
  var islogin;

  checkUserLoginState() async {
    await Shared.getUserSharedPrefernces().then((value) {
      setState(() {
        islogin = value;
      });
    });
  }

  @override
  void initState() {
    checkUserLoginState();
    super.initState();
  }
*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
/*
      home: islogin != null
          ? islogin
              ? PrincipalUsuario()
              : Login()
          : Login(),
          */
      title: 'Paraki',
      theme: appTheme(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => Login(),
        '/principalUsuario': (context) => PrincipalUsuario(),
        '/principalAdmin': (context) => PrincipalAdmin(),
      },
    );
  }
}
