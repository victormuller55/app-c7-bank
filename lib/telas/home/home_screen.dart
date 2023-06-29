import 'package:app_c7_bank/dialogs_home.dart';
import 'package:app_c7_bank/functions/util.dart';
import 'package:app_c7_bank/model/model_conta.dart';
import 'package:app_c7_bank/telas/home/home_bloc.dart';
import 'package:app_c7_bank/telas/home/home_state.dart';
import 'package:app_c7_bank/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  final ContaModel contaModel;
  final String nomeCliente;

  const HomeScreen({Key? key, required this.contaModel, required this.nomeCliente}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc = HomeBloc();
  bool canSeeSaldo = false;

  TextEditingController valorBoletoController = TextEditingController();

  Widget _botaoHome({
    required String title,
    required void Function() onTap,
  }) {
    return getContainer(
      height: 80,
      width: MediaQuery.of(context).size.width / 4,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.yellow, width: 1),
      color: const Color.fromRGBO(21, 21, 20, 1),
      child: Center(
        child: ListTile(
          onTap: onTap,
          leading: const Icon(Icons.attach_money, color: Colors.yellow, size: 30),
          title: getText(title, color: Colors.white, fontSize: 20),
          trailing: const Icon(Icons.arrow_forward_outlined, color: Colors.yellow, size: 30),
        ),
      ),
    );
  }

  Widget _rowBotoes({
    required String title1,
    required void Function() onTap1,
    required String title2,
    required void Function() onTap2,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _botaoHome(title: title1, onTap: onTap1),
        const SizedBox(width: 10),
        _botaoHome(title: title2, onTap: onTap2),
      ],
    );
  }

  void _onChangeState(HomeState state) {
    if (state is HomeErrorState) showSnackBarError(context);
    if (state is HomeSuccessState) showSnackBarSucess(context, message: "Operação realizada com sucesso");
  }

  Widget _bodyState(HomeState state) {
    if (state is HomeLoadingState) return getLoading();
    return _body();
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        getText(getCumprimento() + widget.nomeCliente, bold: true, fontSize: 20, color: Colors.white),
        const SizedBox(height: 10),
        getText("O que gostaria de fazer hoje?", fontSize: 15, color: Colors.white),
        const SizedBox(height: 20),
        _rowBotoes(
          title1: "Pagar boleto",
          onTap1: () => showDialogC7(context, content: contentPopupPagarBoleto(context, bloc: homeBloc, model: widget.contaModel, controllerValor: valorBoletoController)),
          title2: "Fazer transferência",
          onTap2: () => showDialogC7(context, content: []),
        ),
        const SizedBox(height: 20),
        _rowBotoes(
          title1: "Fazer depósito",
          onTap1: () => showDialogC7(context, content: []),
          title2: "PIX",
          onTap2: () => showDialogC7(context, content: []),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(21, 21, 20, 1),
        title: Image.asset("assets/images/logo.png", height: 40),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 18, right: 10),
            child: getText(canSeeSaldo ? "R\$ ${widget.contaModel.saldoConta}" : "R\$ --------", bold: true, fontSize: 17),
          ),
          IconButton(
            onPressed: () => setState(() => canSeeSaldo = !canSeeSaldo),
            icon: Icon(canSeeSaldo ? Icons.visibility_off : Icons.visibility, size: 20, color: Colors.white),
          ),
          const SizedBox(width: 30),
        ],
      ),
      body: getContainer(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        colorsGradient: [
          const Color.fromRGBO(37, 36, 33, 1),
          const Color.fromRGBO(21, 21, 20, 1),
        ],
        child: BlocConsumer<HomeBloc, HomeState>(
          bloc: homeBloc,
          listener: (context, state) => _onChangeState(state),
          builder: (context, state) => _bodyState(state),
        ),
      ),
    );
  }
}
