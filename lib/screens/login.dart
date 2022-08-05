import 'package:estacionamento/http/LoginService.dart';
import 'package:estacionamento/models/Usuario.dart';
import 'package:estacionamento/screens/Dono/PrincipalDono.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../components/Button.dart';
import '../components/Editor.dart';
import 'Admin/PrincipalAdmin.dart';
import 'CadastroUsuario.dart';
import 'PrincipalUsuario.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static const _rotuloCampoCPF = 'CPF';
  static const _dicaCampoCPF = '00000000000';
  static const _rotuloCampoSenha = 'Senha';
  static const _dicaCampoSenha = '00000000';
  static const _textoBotaoEntrar = 'Entrar';
  static const _textoBotaoCadastrar = 'Cadastrar';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controladorCpf = TextEditingController();
  final TextEditingController _controladorSenha = TextEditingController();
  
  String? textoErro = null;

  //
  late SharedPreferences logindata;
  late bool newuser;

  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  @override
  void dispose() {
    _controladorCpf.dispose();
    _controladorSenha.dispose();
    super.dispose();
  }
  //

  void validateAndSave() {
    final FormState? form = _formKey.currentState;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/paraki-logo.png',
                scale: 3,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Editor(
                      controlador: _controladorCpf,
                      //validacao: validaCPF,
                      rotulo: _rotuloCampoCPF,
                      dica: _dicaCampoCPF,
                      teclado: TextInputType.number,
                    ),
                    Editor(
                      controlador: _controladorSenha,
                      //validacao: validaSenha,
                      textoErro: textoErro,
                      rotulo: _rotuloCampoSenha,
                      dica: _dicaCampoSenha,
                      senha: true,
                    ),
                  ],
                ),
              ),
              Button(
                rotulo: _textoBotaoEntrar,
                onPressed: () async {
                  validateAndSave();
                  var usuario = await LoginService().validarLogin(
                      _controladorCpf.text, _controladorSenha.text);
                  if (usuario.nomeUsuario == "") {
                    setState(() {
                      textoErro = "CPF ou senha inválidos!";
                    });
                  }
                  print(usuario);
                  if (usuario.tipo == "Administrador") {
                    logindata.setBool('login', false);
                    logindata.setString('username', usuario.nomeUsuario);
                    logindata.setString('tipo_user', usuario.tipo);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => PrincipalAdmin()),
                    );
                  } else {
                    Usuario u = Usuario(
                      usuario.nomeUsuario,
                      usuario.cpf,
                      usuario.tipo,
                      usuario.modeloCarro,
                      usuario.senha,
                      idUsuario: usuario.idUsuario,
                    );
                    logindata.setBool('login', false);
                    logindata.setInt('id_user', usuario.idUsuario!);
                    logindata.setString('username', usuario.nomeUsuario);
                    logindata.setString('cpf', usuario.cpf);
                    logindata.setString('tipo_user', usuario.tipo);
                    logindata.setString('modelo_carro', usuario.modeloCarro);
                    logindata.setString('senha_user', usuario.senha);
                    if (usuario.tipo == "Motorista") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrincipalUsuario(user: u)),
                      );
                    } else if (usuario.tipo == "Dono de estacionamento") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrincipalDono(user: u)),
                      );
                    }
                  }
                },
              ),
              TextButton(
                child: Text(_textoBotaoCadastrar),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CadastroUsuario()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? validaCPF(cpf) {
    if (cpf == null || cpf.isEmpty) {
      return "O CPF não pode ser vazio";
    }
    return null;
  }

  String? validaSenha(cpf) {
    if (cpf == null || cpf.isEmpty) {
      return "A senha não pode ser vazia";
    }
    return null;
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
        Usuario u = Usuario(
          usuario.nomeUsuario,
          usuario.cpf,
          usuario.tipo,
          usuario.modeloCarro,
          usuario.senha,
          idUsuario: usuario.idUsuario,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PrincipalUsuario(user: u)),
        );
      } else if (usuario.tipo == "Administrador") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PrincipalAdmin()),
        );
      } else if (usuario.tipo == "Dono de estacionamento") {
        Usuario u = Usuario(
          usuario.nomeUsuario,
          usuario.cpf,
          usuario.tipo,
          usuario.modeloCarro,
          usuario.senha,
          idUsuario: usuario.idUsuario,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PrincipalDono(user: u)),
        );
      }
    }
  }
}
