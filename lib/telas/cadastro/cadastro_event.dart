import 'package:app_c7_bank/model/model_cadastro.dart';

abstract class CadastroEvent {}

class CadastroSalvarEvent extends CadastroEvent {
  ClienteModel clienteModel;
  CadastroSalvarEvent(this.clienteModel);
}