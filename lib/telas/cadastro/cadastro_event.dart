import 'package:app_c7_bank/telas/cadastro/cadastro_model.dart';

abstract class CadastroEvent {}

class CadastroSalvarEvent extends CadastroEvent {
  ClienteModel clienteModel;
  CadastroSalvarEvent(this.clienteModel);
}