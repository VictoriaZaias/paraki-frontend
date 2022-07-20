class HorarioFuncionamento {
  final int idHorarioFuncionamento;
  final String horarioInicio;
  final String horarioFim;
  final String diaSemana;
  final String idEstacionamento;

  HorarioFuncionamento(
      this.idHorarioFuncionamento,
      this.horarioInicio,
      this.horarioFim,
      this.diaSemana,
      this.idEstacionamento);

  @override
  String toString() {
    return 'HorarioFuncionamento{id: $idHorarioFuncionamento, horarioInicio: $horarioInicio, horarioFim: $horarioFim, diaSemana: $diaSemana, idEstacionamento: $idEstacionamento}';
  }
}
