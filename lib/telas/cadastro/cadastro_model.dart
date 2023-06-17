class ClienteModel {
  String? nomeCliente;
  String? cpfCliente;
  String? senhaCliente;

  ClienteModel({
    this.nomeCliente,
    this.cpfCliente,
    this.senhaCliente,
  });

  ClienteModel.fromMap(Map<String, dynamic> json) {
    nomeCliente = json['nome_cliente'];
    cpfCliente = json['cpf_cliente'];
    senhaCliente = json['senha_cliente'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome_cliente'] = nomeCliente;
    data['cpf_cliente'] = cpfCliente;
    data['senha_cliente'] = senhaCliente;
    return data;
  }
}
