class ContaModel {
  int? id;
  int? saldoConta;
  String? agenciaConta;
  String? numeroConta;
  bool? ativo;

  ContaModel({
    this.id,
    this.saldoConta,
    this.agenciaConta,
    this.numeroConta,
    this.ativo,
  });

  ContaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    saldoConta = json['saldo_conta'];
    agenciaConta = json['agencia_conta'];
    numeroConta = json['numero_conta'];
    ativo = json['ativo'];
  }
}
