import 'package:app_c7_bank/telas/cadastro/cadastro_event.dart';
import 'package:app_c7_bank/telas/cadastro/cadastro_service.dart';
import 'package:app_c7_bank/telas/cadastro/cadastro_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CadastroBloc extends Bloc<CadastroEvent, CadastroState> {
  CadastroBloc() : super(CadastroInitialState()) {
    on<CadastroSalvarEvent>((event, emit) async {
      emit(CadastroLoadingState());
      try {
        await postUser(event.clienteModel);
        emit(CadastroSuccessState());
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    });
  }
}
