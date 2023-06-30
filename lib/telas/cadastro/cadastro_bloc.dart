import 'dart:convert';

import 'package:app_c7_bank/functions/service.dart';
import 'package:app_c7_bank/model/model_conta.dart';
import 'package:app_c7_bank/telas/cadastro/cadastro_event.dart';
import 'package:app_c7_bank/telas/cadastro/cadastro_service.dart';
import 'package:app_c7_bank/telas/cadastro/cadastro_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CadastroBloc extends Bloc<CadastroEvent, CadastroState> {
  CadastroBloc() : super(CadastroInitialState(contaModel: ContaModel.empty())) {
    on<CadastroSalvarEvent>((event, emit) async {
      emit(CadastroLoadingState(contaModel: ContaModel.empty()));
      try {
        Response response = await postUser(event.clienteModel);
        ContaModel contaModel = ContaModel.fromJson(jsonDecode(response.body));
        emit(CadastroSuccessState(contaModel: contaModel));
      } catch (e) {
        emit(CadastroErrorState(contaModel: ContaModel.empty()));
      }
    });
  }
}
