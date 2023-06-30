import 'package:app_c7_bank/model/model_conta.dart';

abstract class EntrarState {
  ContaModel contaModel;

  EntrarState({required this.contaModel});
}

class EntrarInitialState extends EntrarState {
  EntrarInitialState({required super.contaModel});
}

class EntrarLoadingState extends EntrarInitialState {
  EntrarLoadingState({required super.contaModel});
}

class EntrarSuccessState extends EntrarState {
  EntrarSuccessState({required ContaModel contaModel}) : super(contaModel: contaModel);
}

class EntrarErrorState extends EntrarState {
  EntrarErrorState({required super.contaModel});
}
