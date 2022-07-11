class Estacionamento {
  final String nomeEstacionamento;
  final String cnpj;
  final String cep;
  final String unidadeFederativa;
  final String cidade;
  final String bairro;
  final String logradouro;
  final int numeroEstacionamento;
  final String telefoneEstacionamento;
  final int quantidadeTotalVagas;

  Estacionamento(
      this.nomeEstacionamento,
      this.cnpj,
      this.cep,
      this.unidadeFederativa,
      this.cidade,
      this.bairro,
      this.logradouro,
      this.numeroEstacionamento,
      this.telefoneEstacionamento,
      this.quantidadeTotalVagas);

  @override
  String toString() {
    return 'Estacionamento{nome: $nomeEstacionamento, totalVagas: @quantidadeTotalVagas}';
  }
}
