import 'dart:convert';

import 'package:app_c7_bank/functions/service.dart';
import 'package:app_c7_bank/model/model_conta.dart';
import 'package:app_c7_bank/telas/entrar/entrar_event.dart';
import 'package:app_c7_bank/telas/entrar/entrar_service.dart';
import 'package:app_c7_bank/telas/entrar/entrar_state.dart';
import 'package:bloc/bloc.dart';

class EntrarBloc extends Bloc<EntrarEvent, EntrarState> {
  EntrarBloc() : super(EntrarInitialState(contaModel: ContaModel.empty())) {
    on<EntrarEntrarEvent>((event, emit) async {
      emit(EntrarLoadingState(contaModel: ContaModel.empty()));
      try {
        Response response = await getUser(numero: event.numero, agencia: event.agencia, senha: event.senha);
        ContaModel contaModel = ContaModel.fromJson(jsonDecode(response.body));
        emit(EntrarSuccessState(contaModel: contaModel));
      } catch (e) {
        emit(EntrarErrorState(contaModel: ContaModel.empty()));
      }
    });
  }
}