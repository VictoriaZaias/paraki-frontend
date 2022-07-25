class Caracteristica{
  final int idCaracteristica;
  final String caracteristica;
  final String estacionamento;

  Caracteristica(
      this.idCaracteristica,
      this.caracteristica,
      this.estacionamento,
      );


  @override
  String toString() {
    return 'Caracteristica{caracteristica: $caracteristica}';
  }
}
