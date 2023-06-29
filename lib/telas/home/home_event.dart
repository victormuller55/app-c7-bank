abstract class HomeEvent {}

class HomePagarEvent extends HomeEvent {
  String conta;
  double valor;

  HomePagarEvent(this.conta, this.valor);
}

class HomeDepositoEvent extends HomeEvent {
  String conta;
  double valor;

  HomeDepositoEvent(this.conta, this.valor);
}

class HomeTranferenciaEvent extends HomeEvent {
  String conta;
  String contaReceber;
  double valor;

  HomeTranferenciaEvent(this.conta, this.contaReceber, this.valor);
}

class HomePixEvent extends HomeEvent {
  String conta;
  String cpf;
  double valor;

  HomePixEvent(this.conta, this.cpf, this.valor);
}
