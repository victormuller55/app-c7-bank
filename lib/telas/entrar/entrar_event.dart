abstract class EntrarEvent {}

class EntrarEntrarEvent extends EntrarEvent {
  String numero;
  String agencia;
  String senha;

  EntrarEntrarEvent({required this.numero, required this.agencia, required this.senha});
}
