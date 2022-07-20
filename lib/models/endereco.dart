class Endereco{
  final int idEndereco;
  final String bairro;
  final String logradouro;
  final String tipoLogradouro;
  final String cidade;
  final String unidadeFederativa;
  final String cep;

  Endereco(
      this.idEndereco,
      this.bairro,
      this.logradouro,
      this.tipoLogradouro,
      this.cidade,
      this.unidadeFederativa,
      this.cep
      );


  @override
  String toString() {
    return 'Endereco{bairro: $bairro, logradouro: $logradouro, tipoLogradouro: $tipoLogradouro, cidade: $cidade, unidadeFederativa: $unidadeFederativa, cep $cep}';
  }
}
