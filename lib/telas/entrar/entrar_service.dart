import 'package:app_c7_bank/functions/service.dart';

Future<Response> getUser({required String numero, required String agencia, required String senha}) async {
  return await getHTTP(endpoint: "http://localhost/v1/c7-bank/cliente", parameters: {
    "numero": numero,
    "agencia": agencia,
    "senha": senha,
  });
}
