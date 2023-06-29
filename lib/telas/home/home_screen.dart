import 'package:app_c7_bank/dialogs_home.dart';
import 'package:app_c7_bank/telas/home/home_bloc.dart';
import 'package:app_c7_bank/telas/home/home_state.dart';
import 'package:app_c7_bank/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../model/model_conta.dart';

class HomeScreen extends StatefulWidget {
  final ContaModel contaModel;
  final String nomeCliente;

  const HomeScreen({Key? key, required this.contaModel, required this.nomeCliente}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc = HomeBloc();

  TextEditingController controllerDeposito = TextEditingController();
  TextEditingController valorBoletoController = TextEditingController();
  TextEditingController numeroContaTranferirController = TextEditingController();
  TextEditingController valorTranferirController = TextEditingController();
  TextEditingController cpfPixController = TextEditingController();
  TextEditingController valorPixController = TextEditingController();

  Widget _botao({required String title, required String subtitle, required void Function() function}) {
    return GestureDetector(
      onTap: function,
      child: getContainer(
        margin: const EdgeInsets.all(8),
        height: 100,
        width: MediaQuery.of(context).size.width / 4,
        color: const Color.fromRGBO(45, 45, 45, 1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.yellow, width: 1),
        boxShadow: [
          const BoxShadow(color: Colors.black, offset: Offset(10, 10), blurRadius: 20),
        ],
        child: Center(
          child: Row(
            children: [
              const SizedBox(width: 20),
              const Icon(Icons.attach_money, color: Colors.yellow, size: 40),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getText(title, color: Colors.white, fontSize: 20, bold: true),
                  const SizedBox(height: 10),
                  getText(subtitle, color: Colors.white, fontSize: 15),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body({double? valor}) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          end: Alignment.bottomRight,
          begin: Alignment.topLeft,
          colors: [
            Color.fromRGBO(37, 36, 33, 1),
            Color.fromRGBO(21, 21, 20, 1),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getText("Seja bem vindo(a) ", bold: true, color: Colors.white, fontSize: 20),
                getText("${widget.nomeCliente}!", bold: true, color: Colors.yellow, fontSize: 20),
              ],
            ),
            const SizedBox(height: 10),
            getText("R\$ ${valor ?? widget.contaModel.saldoConta.toString()}", color: Colors.white, fontSize: 17),
            const SizedBox(height: 10),
            getText("O que gostaria de fazer hoje?", color: Colors.white, fontSize: 17),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _botao(
                  title: "Pagar",
                  subtitle: "Pague seus boletos aqui.",
                  function: () => showDialogC7(
                    context,
                    content: [
                      getFormfield(hintText: "R\$100,00", labelText: "Digite o valor", width: 400, textEditingController: valorBoletoController),
                      const SizedBox(height: 10),
                      getButton(text: "Pagar", function: () => functionPagar(context, bloc: homeBloc, model: widget.contaModel, textEditingController: valorBoletoController)),
                    ],
                  ),
                ),
                _botao(
                  title: "Transferir",
                  subtitle: "Faça transferencias com segurança.",
                  function: () => showDialogC7(
                    context,
                    content: [
                      getFormfield(hintText: "1234567-8", labelText: "Digite o número da conta", width: 400, textEditingController: numeroContaTranferirController),
                      getFormfield(hintText: "R\$100,00", labelText: "Digite o valor", width: 400, textEditingController: valorTranferirController),
                      const SizedBox(height: 20),
                      getButton(text: "Transferir", function: () => functionTranferir(context, bloc: homeBloc, model: widget.contaModel, numeroContaController: numeroContaTranferirController, valorController: valorTranferirController)),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _botao(
                  title: "Deposito",
                  subtitle: "Adicione mais dinheiro na sua conta!",
                  function: () => showDialogC7(
                    context,
                    content: [
                      getFormfield(hintText: "R\$100,00", labelText: "Digite o valor", width: 400, textEditingController: controllerDeposito),
                      const SizedBox(height: 10),
                      getButton(text: "Depositar", function: () => functionDeposito(context, bloc: homeBloc, model: widget.contaModel, textEditingController: controllerDeposito)),
                    ],
                  ),
                ),
                _botao(
                  title: "Transferencia PIX",
                  subtitle: "Faça PIX com rapidez.",
                  function: () => showDialogC7(
                    context,
                    content: [
                      getFormfield(hintText: "123.456.789-10", labelText: "Digite o CPF", width: 400, textEditingController: numeroContaTranferirController),
                      getFormfield(hintText: "R\$100,00", labelText: "Digite o valor", width: 400, textEditingController: valorTranferirController),
                      const SizedBox(height: 20),
                      getButton(text: "Transferir", function: () => functionPix(context, bloc: homeBloc, model: widget.contaModel, numeroContaController: numeroContaTranferirController, valorController: valorTranferirController)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _blocBuilder() {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listener: (context, state) {

        var snackBarError = SnackBar(
          content: getText("Ocorreu um erro durante a operação, tente novamente mais tarde!"),
          backgroundColor: Colors.red,
          action: SnackBarAction(
            label: 'Fechar',
            onPressed: () => ScaffoldMessenger.of(context).clearSnackBars(),
            backgroundColor: Colors.red.shade700,
            textColor: Colors.white,
          ),
        );

        var snackBarSuccess = SnackBar(
          content: getText("Operação realizada com sucesso"),
          backgroundColor: Colors.green,
          action: SnackBarAction(
            label: 'Fechar',
            onPressed: () => ScaffoldMessenger.of(context).clearSnackBars(),
            backgroundColor: Colors.green.shade700,
            textColor: Colors.white,
          ),
        );

        if (state is HomeErrorState) ScaffoldMessenger.of(context).showSnackBar(snackBarError);
        if (state is HomeSuccessState) ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess);
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  end: Alignment.bottomRight,
                  begin: Alignment.topLeft,
                  colors: [
                    Color.fromRGBO(37, 36, 33, 1),
                    Color.fromRGBO(21, 21, 20, 1),
                  ],
                ),
              ),
              child: Center(child: LoadingAnimationWidget.discreteCircle(color: Colors.yellow, size: 40)),
            );

          default:
            return _body(valor: state.saldoAtual);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(21, 21, 20, 1),
        title: Image.asset("assets/images/logo.png", height: 40),
        centerTitle: true,
      ),
      body: _blocBuilder(),
    );
  }
}
