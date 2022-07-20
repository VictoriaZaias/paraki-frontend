import 'package:estacionamento/models/endereco.dart';

class Estacionamento{
  final int idEstacionamento;
  final String nomeEstacionamento;
  final String cnpj;
  final int qtdTotalVagas;
  final int nroEstacionamento;
  final String telefone;
  final int valorHora;
  //final Endereco endereco;

  Estacionamento(
      this.idEstacionamento,
      this.nomeEstacionamento,
      this.cnpj,
      this.qtdTotalVagas,
      this.nroEstacionamento,
      this.telefone,
      this.valorHora,
      //this.endereco
      );

  @override
  String toString() {
    return 'Estacionamento{nome: $nomeEstacionamento, cnpj: $cnpj, qtdTotalVagas: $qtdTotalVagas, nroEstacionamento: $nroEstacionamento, telefone: $telefone, valorHora: $valorHora}';
  }
}
