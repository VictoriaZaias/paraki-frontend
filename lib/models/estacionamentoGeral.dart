class estacionamentoGeral{
  final int idEstacionamento;
  final String nomeEstacionamento;
  //final String CNPJ;
  //final String CEP;
  //final String estado;
  //final String cidade;
  //final String bairro;
  //final String logradouro;
  //final int numeroEstacionamento;
  //final String telefone;
  final int quantidadeTotalVagas;
  //final String caracteristica;
  //final String horarioInicio;
  //final String horarioFim;
  //final String precoHora;

  estacionamentoGeral(
      this.idEstacionamento,
      this.nomeEstacionamento,
      //this.CNPJ,
      //this.CEP,
      //this.estado,
      //this.cidade,
      //this.bairro,
      //this.logradouro,
      //this.numeroEstacionamento,
      //this.telefone,
      this.quantidadeTotalVagas
      //this.caracteristica,
      //this.horarioInicio,
      //this.horarioFim,
      //this.precoHora
      );


  @override
  String toString() {
    return 'Estacionamento{nome: $nomeEstacionamento, totalVagas: $quantidadeTotalVagas}';
  }
}
