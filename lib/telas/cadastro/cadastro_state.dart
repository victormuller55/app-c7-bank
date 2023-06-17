
import 'package:app_c7_bank/telas/cadastro/cadastro_model.dart';

abstract class CadastroState {
  // ClienteModel? userModel;
  // YKError? error;

  // CadastroState({
    // this.userModel,
    // this.error,
  // });
}

class CadastroInitialState extends CadastroState {}

class CadastroLoadingState extends CadastroInitialState {}

class CadastroSuccessState extends CadastroState {
  // CadastroSuccessState({ClienteModel? clienteModel}) : super(userModel: clienteModel);
}

class CadastroErrorState extends CadastroState {}