import 'dart:convert';

import 'package:app_c7_bank/telas/cadastro/cadastro_model.dart';
import 'package:http/http.dart' as http;

Map<String, String>? header = <String, String>{'Content-Type': 'application/json; charset=UTF-8'};

Future<ApiResult> postUser(ClienteModel userModel) async {
  return await postHTTP(endpoint: "localhost/v1/c7-bank/cliente", body: userModel.toMap());
}

String getParametersFormatted({required Map<String, dynamic>? parameters}) {
  List<String> list = [];

  if (parameters != null) {
    parameters.forEach((key, value) => list.add("$key=$value"));
    return '?${list.join('&')}';
  }

  return "";
}

Future<ApiResult> postHTTP({required String endpoint, required Map<String, dynamic> body, Map<String, String>? parameters}) async {
  http.Response endpointResult = await http.post(Uri.parse(endpoint + getParametersFormatted(parameters: parameters)), headers: header, body: jsonEncode(body));
  return ApiResult(statusCode: endpointResult.statusCode, body: endpointResult.body);
}

class ApiResult {
  int? statusCode;
  String? body;

  ApiResult({this.statusCode, this.body});
}
