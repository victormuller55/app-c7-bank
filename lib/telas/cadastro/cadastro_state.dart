import 'package:app_c7_bank/model/model_conta.dart';

abstract class CadastroState {
  ContaModel? contaModel;
  CadastroState({this.contaModel});
}

class CadastroInitialState extends CadastroState {}

class CadastroLoadingState extends CadastroInitialState {}

class CadastroSuccessState extends CadastroState {
  CadastroSuccessState({required ContaModel contaModel}) : super(contaModel: contaModel);
}

class CadastroErrorState extends CadastroState {}
