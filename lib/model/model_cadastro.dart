class ClienteModel {
  String? nomeCliente;
  String? cpfCliente;
  String? senhaCliente;

  ClienteModel({
    this.nomeCliente,
    this.cpfCliente,
    this.senhaCliente,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome_cliente'] = nomeCliente;
    data['cpf_cliente'] = cpfCliente;
    data['senha_cliente'] = senhaCliente;
    return data;
  }
}
