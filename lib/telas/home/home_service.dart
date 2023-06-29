import '../../functions/service.dart';

Future<Response> pagar({required String conta, required double valor}) async {
  return await putHTTP(
    endpoint: "http://localhost/v1/c7-bank/conta/pagarBoleto",
    parameters: {
      "conta": conta,
      "valor": valor.toString(),
    },
  );
}

Future<Response> deposito({required String conta, required double valor}) async {
  return await putHTTP(
    endpoint: "http://localhost/v1/c7-bank/conta/adicionarSaldo",
    parameters: {
      "conta": conta,
      "valor": valor.toString(),
    },
  );
}

Future<Response> tranferencia({required String conta, required String contaReceber, required double valor}) async {
  return await putHTTP(
    endpoint: "http://localhost/v1/c7-bank/conta/tranferir",
    parameters: {
      "contaOrigem": conta,
      "contaReceber": contaReceber,
      "valor": valor.toString(),
    },
  );
}

Future<Response> pix({required String conta, required String cpf, required double valor}) async {
  return await putHTTP(
    endpoint: "http://localhost/v1/c7-bank/conta/pix",
    parameters: {
      "contaOrigem": conta,
      "cpf": cpf,
      "valor": valor.toString(),
    },
  );
}
