class Usuario {
  final String idUsuario;
  final String nomeUsuario;
  final String cpf;
  final String tipo;
  final String modeloCarro;
  final String senha;

  Usuario(
      this.idUsuario,
      this.nomeUsuario,
      this.cpf,
      this.tipo,
      this.modeloCarro,
      this.senha);

  @override
  String toString() {
    return 'Usuario{cpf: $cpf, senha: $senha}';
  }
}
