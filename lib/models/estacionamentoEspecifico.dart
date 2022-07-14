class estacionamentoEspecifico{
  final int idEstacionamento;
  final String nomeEstacionamento;
  //final String logradouro;
  //final int numeroEstacionamento;
  //final String precoHora;
  final int quantidadeTotalVagas;

  estacionamentoEspecifico(
      this.idEstacionamento,
      this.nomeEstacionamento,
      //this.logradouro,
      //this.numeroEstacionamento,
      //this.precoHora,
      this.quantidadeTotalVagas
      );


  @override
  String toString() {
    return 'Estacionamento{nome: $nomeEstacionamento, totalVagas: $quantidadeTotalVagas}';
  }
}