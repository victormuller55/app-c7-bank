import 'package:app_c7_bank/model/model_conta.dart';
import 'package:app_c7_bank/telas/home/home_bloc.dart';
import 'package:app_c7_bank/telas/home/home_event.dart';
import 'package:app_c7_bank/widget.dart';
import 'package:flutter/material.dart';

void showDialogC7(BuildContext context, {required List<Widget> content}) {
  showDialog(
    context: context,
    builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Dialog(
            shadowColor: Colors.black,
            backgroundColor: Colors.transparent,
            child: getContainer(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(15),
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 15),
                  SizedBox(height: 85, child: Image.asset("assets/images/logo.png")),
                  const SizedBox(height: 15),
                  ...content,
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}

void functionDeposito(
  BuildContext context, {
  required HomeBloc bloc,
  required ContaModel model,
  required TextEditingController controllerValor,
}) {
  if (controllerValor.text.isNotEmpty) {
    bloc.add(HomeDepositoEvent(model.numeroConta, double.parse(controllerValor.text)));
  } else {
    showSnackBarWarning(context, message: "Preencha todos os campos.");
  }

  Future.delayed(const Duration(milliseconds: 500)).then((value) => Navigator.pop(context));
}

void functionPagar(
  BuildContext context, {
  required HomeBloc bloc,
  required ContaModel model,
  required TextEditingController controllerValor,
}) {
  if (controllerValor.text.isNotEmpty) {
    bloc.add(HomePagarEvent(model.numeroConta, double.parse(controllerValor.text)));
  } else {
    showSnackBarWarning(context, message: "Preencha todos os campos.");
  }

  Future.delayed(const Duration(milliseconds: 500)).then((value) => Navigator.pop(context));
}

void functionTranferir(
  BuildContext context, {
  required HomeBloc bloc,
  required ContaModel model,
  required TextEditingController controllerNumeroConta,
  required TextEditingController controllerValor,
}) {
  if (controllerNumeroConta.text.isNotEmpty) {
    bloc.add(HomeTranferenciaEvent(model.numeroConta, controllerNumeroConta.text, double.parse(controllerValor.text)));
  } else {
    showSnackBarWarning(context, message: "Preencha todos os campos.");
  }

  Future.delayed(const Duration(milliseconds: 500)).then((value) => Navigator.pop(context));
}

void functionTranferirPIX(
  BuildContext context, {
  required HomeBloc bloc,
  required ContaModel model,
  required TextEditingController controllerCPF,
  required TextEditingController controllerValor,
}) {
  if (controllerCPF.text.isNotEmpty) {
    bloc.add(HomePixEvent(model.numeroConta, controllerCPF.text, double.parse(controllerValor.text)));
  } else {
    showSnackBarWarning(context, message: "Preencha todos os campos.");
  }

  Future.delayed(const Duration(milliseconds: 500)).then((value) => Navigator.pop(context));
}

List<Widget> contentPopupPagarBoleto(
  BuildContext context, {
  required HomeBloc bloc,
  required ContaModel model,
}) {
  TextEditingController controllerValor = TextEditingController();

  return [
    getFormfield(
      hintText: "R\$ 1000",
      labelText: "Digite o valor",
      textEditingController: controllerValor,
      width: 400,
    ),
    const SizedBox(height: 20),
    getButtonPopup(
      text: "Pagar",
      function: () => functionPagar(
        context,
        controllerValor: controllerValor,
        model: model,
        bloc: bloc,
      ),
    ),
  ];
}

List<Widget> contentPopupTranferencia(
  BuildContext context, {
  required HomeBloc bloc,
  required ContaModel model,
}) {
  TextEditingController controllerNumeroConta = TextEditingController();
  TextEditingController controllerValor = TextEditingController();

  return [
    getFormfield(
      hintText: "1234567-8",
      labelText: "Digite o numero da conta.",
      textEditingController: controllerNumeroConta,
      width: 400,
    ),
    getFormfield(
      hintText: "R\$ 1000",
      labelText: "Digite o valor",
      textEditingController: controllerValor,
      width: 400,
    ),
    const SizedBox(height: 20),
    getButtonPopup(
      text: "Transfêrir",
      function: () => functionTranferir(
        context,
        controllerNumeroConta: controllerNumeroConta,
        controllerValor: controllerValor,
        model: model,
        bloc: bloc,
      ),
    ),
  ];
}

List<Widget> contentPopupPix(
  BuildContext context, {
  required HomeBloc bloc,
  required ContaModel model,
}) {
  TextEditingController controllerCPF = TextEditingController();
  TextEditingController controllerValor = TextEditingController();

  return [
    getFormfield(
      hintText: "123.456.789-10",
      labelText: "Digite o CPF da conta.",
      textEditingController: controllerCPF,
      width: 400,
    ),
    getFormfield(
      hintText: "R\$ 1000",
      labelText: "Digite o valor",
      textEditingController: controllerValor,
      width: 400,
    ),
    const SizedBox(height: 20),
    getButtonPopup(
      text: "Transfêrir PIX",
      function: () => functionTranferirPIX(
        context,
        controllerCPF: controllerCPF,
        controllerValor: controllerValor,
        model: model,
        bloc: bloc,
      ),
    ),
  ];
}

List<Widget> contentPopupDeposito(
  BuildContext context, {
  required HomeBloc bloc,
  required ContaModel model,
}) {
  TextEditingController controllerValor = TextEditingController();

  return [
    const SizedBox(height: 10),
    getFormfield(
      hintText: "R\$ 1000",
      labelText: "Digite o valor",
      textEditingController: controllerValor,
      width: 400,
    ),
    const SizedBox(height: 20),
    getButtonPopup(
      text: "Depositar.",
      function: () => functionDeposito(
        context,
        controllerValor: controllerValor,
        model: model,
        bloc: bloc,
      ),
    ),
  ];
}
