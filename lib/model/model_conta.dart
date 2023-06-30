class ContaModel {
  int id;
  double saldoConta;
  String agenciaConta;
  String numeroConta;
  bool ativo;

  ContaModel({
    required this.id,
    required this.saldoConta,
    required this.agenciaConta,
    required this.numeroConta,
    required this.ativo,
  });

  factory ContaModel.empty() {
    return ContaModel(
      id: 0,
      agenciaConta: "",
      numeroConta: "",
      saldoConta: 0,
      ativo: false,
    );
  }

  factory ContaModel.fromJson(Map<String, dynamic> json) {
    return ContaModel(
      id: json['id'],
      saldoConta: json['saldo_conta'],
      agenciaConta: json['agencia_conta'],
      numeroConta: json['numero_conta'],
      ativo: json['ativo'],
    );
  }
}
