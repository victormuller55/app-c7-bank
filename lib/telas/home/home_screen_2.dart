import 'package:app_c7_bank/telas/home/home_bloc.dart';
import 'package:app_c7_bank/telas/home/home_state.dart';
import 'package:app_c7_bank/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {

  HomeBloc homeBloc = HomeBloc();

  void _onChangeState(HomeState state) {
    if (state is HomeErrorState) ScaffoldMessenger.of(context).showSnackBar(snackBarError);
    if (state is HomeSuccessState) ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess);
  }

  Widget _body() {
    return Container();
  }

  Widget _blocBuilder() {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listener: (context, state) => _onChangeState(state),
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState: return getLoading();
          default: return _body();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _blocBuilder());
  }
}
