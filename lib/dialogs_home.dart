import 'package:app_c7_bank/model/model_conta.dart';
import 'package:app_c7_bank/telas/home/home_bloc.dart';
import 'package:app_c7_bank/telas/home/home_event.dart';
import 'package:app_c7_bank/widget.dart';
import 'package:flutter/material.dart';

void functionDeposito(
  BuildContext context, {
  required HomeBloc bloc,
  required ContaModel model,
  required TextEditingController textEditingController,
}) {
  var snackBarWarning = SnackBar(
    content: getText("Preencha todos os campos"),
    backgroundColor: Colors.orange,
    action: SnackBarAction(
      label: 'Fechar',
      onPressed: () => ScaffoldMessenger.of(context).clearSnackBars(),
      backgroundColor: Colors.orange.shade700,
      textColor: Colors.white,
    ),
  );

  if (textEditingController.text.isNotEmpty) {
    bloc.add(HomeDepositoEvent(model.numeroConta ?? "", double.parse(textEditingController.text)));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(snackBarWarning);
  }

  Navigator.pop(context);
}

void functionPagar(
  BuildContext context, {
  required HomeBloc bloc,
  required ContaModel model,
  required TextEditingController textEditingController,
}) {
  var snackBarWarning = SnackBar(
    content: getText("Preencha todos os campos"),
    backgroundColor: Colors.orange,
    action: SnackBarAction(
      label: 'Fechar',
      onPressed: () => ScaffoldMessenger.of(context).clearSnackBars(),
      backgroundColor: Colors.orange.shade700,
      textColor: Colors.white,
    ),
  );

  if (textEditingController.text.isNotEmpty) {
    bloc.add(HomePagarEvent(model.numeroConta ?? "", double.parse(textEditingController.text)));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(snackBarWarning);
  }

  Navigator.pop(context);
}

void functionTranferir(
  BuildContext context, {
  required HomeBloc bloc,
  required ContaModel model,
  required TextEditingController numeroContaController,
  required TextEditingController valorController,
}) {
  var snackBarWarning = SnackBar(
    content: getText("Preencha todos os campos"),
    backgroundColor: Colors.orange,
    action: SnackBarAction(
      label: 'Fechar',
      onPressed: () => ScaffoldMessenger.of(context).clearSnackBars(),
      backgroundColor: Colors.orange.shade700,
      textColor: Colors.white,
    ),
  );

  if (numeroContaController.text.isNotEmpty) {
    bloc.add(HomeTranferenciaEvent(model.numeroConta ?? "", numeroContaController.text, double.parse(numeroContaController.text)));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(snackBarWarning);
  }

  Navigator.pop(context);
}

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

List<Widget> contentPopupPagarBoleto(
  BuildContext context, {
  required HomeBloc bloc,
  required ContaModel model,
  required TextEditingController controllerValor,
}) {
  return [
    getFormfield(
      hintText: "R\$ 1000",
      labelText: "Digite o valor",
      textEditingController: controllerValor,
      width: 400,
    ),
    const SizedBox(height: 20),
    getButton(
      text: "Pagar",
      function: () => functionPagar(
        context,
        textEditingController: controllerValor,
        model: model,
        bloc: bloc,
      ),
    ),
  ];
}
