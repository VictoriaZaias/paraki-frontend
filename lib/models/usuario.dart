class Usuario {
  int idUsuario;
  String nomeUsuario;
  String cpf;
  String tipo;
  String modeloCarro;
  String senha;

  Usuario(
      this.idUsuario,
      this.nomeUsuario,
      this.cpf,
      this.tipo,
      this.modeloCarro,
      this.senha);


  int get getIdUsuario{
    return idUsuario;
  }

  set setIdUsuario(int id){
    idUsuario = id;
  }

  String get getNomeUsuario{
    return nomeUsuario;
  }

  set setNomeUsuario(String nome){
    nomeUsuario = nome;
  }

  String get getCPF{
    return cpf;
  }

  set setCPF(String cpfUsuario){
    cpf = cpfUsuario;
  }

  String get getTipoUsuario{
    return tipo;
  }

  set setTipoUsuario(String tipoUsuario){
    tipo = tipoUsuario;
  }

  String get getIdModeloCarro{
    return modeloCarro;
  }

  set setIdModeloCarro(String idModeloCarro){
    modeloCarro = idModeloCarro;
  }

  String get getSenha{
    return senha;
  }

  set setSenha(String senhaUsuario){
    senha = senhaUsuario;
  }

  @override
  String toString() {
    return 'Usuario{Nome: $nomeUsuario, cpf: $cpf, senha: $senha}';
  }
}
