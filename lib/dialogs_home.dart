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
    builder: (context) => Padding(
      padding: const EdgeInsets.only(top: 150, bottom: 150),
      child: Dialog(
        alignment: Alignment.center,
        shadowColor: Colors.black,
        elevation: 2,
        backgroundColor: Colors.transparent,
        child: getContainer(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(15),
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 85, child: Image.asset("assets/images/logo.png")),
              const SizedBox(height: 15),
              ...content,
            ],
          ),
        ),
      ),
    ),
  );
}
