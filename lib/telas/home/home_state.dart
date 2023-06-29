abstract class HomeState {
  double? saldoAtual;

  HomeState({this.saldoAtual});
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeInitialState {}

class HomeSuccessState extends HomeState {
  HomeSuccessState({required double saldoAtual}) : super(saldoAtual: saldoAtual);
}

class HomeErrorState extends HomeState {}
