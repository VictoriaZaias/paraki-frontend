class Estacionamento {
  final int idEstacionamento;
  final String nomeEstacionamento;
  final String cnpj;
  //final String cep;
 // final String unidadeFederativa;
  //final String cidade;
  //final String bairro;
  //final String logradouro;
  //final int numeroEstacionamento;
  final String telefoneEstacionamento;
  final int quantidadeTotalVagas;
  final String usuario;


  Estacionamento(
      this.idEstacionamento,
      this.nomeEstacionamento,
      this.cnpj,
      //this.cep,
     // this.unidadeFederativa,
      //this.cidade,
      //this.bairro,
      //this.logradouro,
      //this.numeroEstacionamento,
      this.telefoneEstacionamento,
      this.quantidadeTotalVagas,
      this.usuario);


  @override
  String toString() {
    return 'Estacionamento{nome: $nomeEstacionamento, totalVagas: $quantidadeTotalVagas}';
  }
}
