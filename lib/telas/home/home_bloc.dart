import 'package:app_c7_bank/functions/service.dart';
import 'package:app_c7_bank/telas/home/home_event.dart';
import 'package:app_c7_bank/telas/home/home_service.dart';
import 'package:app_c7_bank/telas/home/home_state.dart';
import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeDepositoEvent>((event, emit) async {
      emit(HomeLoadingState());
      try {
        Response response = await deposito(conta: event.conta, valor: event.valor);
        emit(HomeSuccessState(saldoAtual: double.parse(response.body)));
      } catch (e) {
        emit(HomeErrorState());
      }
    });
    on<HomePagarEvent>((event, emit) async {
      emit(HomeLoadingState());
      try {
        Response response = await pagar(conta: event.conta, valor: event.valor);
        emit(HomeSuccessState(saldoAtual: double.parse(response.body)));
      } catch (e) {
        emit(HomeErrorState());
      }
    });
    on<HomeTranferenciaEvent>((event, emit) async {
      emit(HomeLoadingState());
      try {
        Response response = await tranferencia(conta: event.conta, contaReceber: event.contaReceber, valor: event.valor);
        emit(HomeSuccessState(saldoAtual: double.parse(response.body)));
      } catch (e) {
        emit(HomeErrorState());
      }
    });
    on<HomePixEvent>((event, emit) async {
      emit(HomeLoadingState());
      try {
        Response response = await pix(conta: event.conta, cpf: event.cpf, valor: event.valor);
        emit(HomeSuccessState(saldoAtual: double.parse(response.body)));
      } catch (e) {
        emit(HomeErrorState());
      }
    });
  }
}
