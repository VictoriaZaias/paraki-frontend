class Usuario {
  final int idUsuario;
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
    return 'Usuario{Nome: $nomeUsuario, cpf: $cpf, senha: $senha}';
  }
}
