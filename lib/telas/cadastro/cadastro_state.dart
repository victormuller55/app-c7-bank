import 'package:app_c7_bank/model/model_conta.dart';

abstract class CadastroState {
  ContaModel contaModel;
  CadastroState({required this.contaModel});
}

class CadastroInitialState extends CadastroState {
  CadastroInitialState({required super.contaModel});
}

class CadastroLoadingState extends CadastroInitialState {
  CadastroLoadingState({required super.contaModel});
}

class CadastroSuccessState extends CadastroState {
  CadastroSuccessState({required ContaModel contaModel}) : super(contaModel: contaModel);
}

class CadastroErrorState extends CadastroState {
  CadastroErrorState({required super.contaModel});
}
