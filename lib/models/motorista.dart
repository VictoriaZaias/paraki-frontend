class Motorista {
  final String nomeMotorista;
  final String cpf;
  final int modeloCarro;
  final String senha;

  Motorista(this.nomeMotorista, this.cpf, this.modeloCarro, this.senha);

  @override
  String toString() {
    return 'Motorista{cpf: $cpf, senha: $senha}';
  }
}