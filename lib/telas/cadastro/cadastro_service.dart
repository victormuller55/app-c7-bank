import 'package:app_c7_bank/functions/service.dart';
import 'package:app_c7_bank/model/model_cadastro.dart';

Future<Response> postUser(ClienteModel clienteModel) async {
  return await postHTTP(endpoint: "http://localhost/v1/c7-bank/cliente", body: clienteModel.toMap());
}