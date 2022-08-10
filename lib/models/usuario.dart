class Usuario {
  final int? idUsuario;
  final String nomeUsuario;
  final String cpf;
  final String tipo;
  final String modeloCarro;
  final String senha;

  Usuario(
    this.nomeUsuario,
    this.cpf,
    this.tipo,
    this.modeloCarro,
    this.senha, {
    this.idUsuario,
  });

  @override
  String toString() {
    return 'Usuario{Nome: $nomeUsuario, cpf: $cpf, tipo: $tipo, modeloCarro: $modeloCarro, senha: $senha}';
  }
}
