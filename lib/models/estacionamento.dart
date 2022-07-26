import 'package:estacionamento/models/Caracteristica.dart';
import 'package:estacionamento/models/Endereco.dart';
import 'package:estacionamento/models/HorarioFuncionamento.dart';

class Estacionamento{
  final int idEstacionamento;
  final String nomeEstacionamento;
  final String cnpj;
  final int qtdTotalVagas;
  final int qtdVagasDisponiveis;
  final int nroEstacionamento;
  final String telefone;
  final double valorHora;
  final Endereco endereco;
  final List<HorarioFuncionamento> horarios;
  final List<Caracteristica> caracteristicas;

  Estacionamento(
      this.idEstacionamento,
      this.nomeEstacionamento,
      this.cnpj,
      this.qtdTotalVagas,
      this.qtdVagasDisponiveis,
      this.nroEstacionamento,
      this.telefone,
      this.valorHora,
      this.endereco,
      this.horarios,
      this.caracteristicas
      );

  @override
  String toString() {
    return 'Estacionamento{nome: $nomeEstacionamento, cnpj: $cnpj, qtdTotalVagas: $qtdTotalVagas, qtdVagasDisponiveis: $qtdVagasDisponiveis, nroEstacionamento: $nroEstacionamento, telefone: $telefone, valorHora: $valorHora, endereco: $endereco, horarios: $horarios, caracteristicas: $caracteristicas}';
  }
}
