import 'package:app_c7_bank/model/model_cadastro.dart';
import 'package:app_c7_bank/model/model_conta.dart';
import 'package:app_c7_bank/telas/cadastro/cadastro_bloc.dart';
import 'package:app_c7_bank/telas/cadastro/cadastro_event.dart';
import 'package:app_c7_bank/telas/cadastro/cadastro_state.dart';
import 'package:app_c7_bank/telas/home/home_screen.dart';
import 'package:app_c7_bank/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({Key? key}) : super(key: key);

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  CadastroBloc cadastroBloc = CadastroBloc();

  TextEditingController nome = TextEditingController();
  TextEditingController cpf = TextEditingController();
  TextEditingController senha = TextEditingController();

  MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  void _salvarCliente() {
    var snackBarAviso = SnackBar(
      content: getText("Todos os campos são obrigatórios!"),
      backgroundColor: Colors.orange,
      action: SnackBarAction(
        label: 'Fechar',
        onPressed: () => ScaffoldMessenger.of(context).clearSnackBars(),
        backgroundColor: Colors.orange.shade700,
        textColor: Colors.white,
      ),
    );

    if (nome.text.isNotEmpty && cpf.text.isNotEmpty && senha.text.isNotEmpty) {
      ClienteModel clienteModel = ClienteModel(nomeCliente: nome.value.text, cpfCliente: cpf.value.text, senhaCliente: senha.value.text);
      cadastroBloc.add(CadastroSalvarEvent(clienteModel));
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBarAviso);
    }
  }

  Widget _botao() {
    return AnimatedButton(
      width: MediaQuery.of(context).size.width / 3,
      text: cadastroBloc.state is CadastroLoadingState ? "ENVIANDO DADOS..." : 'CADASTRAR',
      selectedTextColor: Colors.black,
      backgroundColor: Colors.yellow,
      borderRadius: 10,
      transitionType: TransitionType.LEFT_CENTER_ROUNDER,
      textStyle: const TextStyle(fontSize: 17, color: Color.fromRGBO(46, 45, 39, 1), fontWeight: FontWeight.bold),
      onPress: () => _salvarCliente(),
    );
  }

  Widget _builderButtom() {
    return BlocConsumer<CadastroBloc, CadastroState>(
      bloc: cadastroBloc,
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
          content: getText("Conta criada com sucesso"),
          backgroundColor: Colors.green,
          action: SnackBarAction(
            label: 'Fechar',
            onPressed: () => ScaffoldMessenger.of(context).clearSnackBars(),
            backgroundColor: Colors.green.shade700,
            textColor: Colors.white,
          ),
        );

        if (state is CadastroErrorState) ScaffoldMessenger.of(context).showSnackBar(snackBarError);
        if (state is CadastroErrorState) setState(() {});
        if (state is CadastroSuccessState) ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess);
        if (state is CadastroSuccessState) Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(contaModel: state.contaModel ?? ContaModel(), nomeCliente: nome.text)));

        },

      builder: (context, state) {
        switch (state.runtimeType) {
          case CadastroLoadingState:
            return _botao();

          default:
            return _botao();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: cadastroBloc.state is CadastroLoadingState ? LoadingAnimationWidget.discreteCircle(color: Colors.yellow, size: 40) : null,
      body: Container(
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getText("Por que escolher o ", color: Colors.white, fontSize: 48, bold: true),
                const SizedBox(height: 10),
                getText("C7 Bank?", color: Colors.yellow, fontSize: 48, bold: true),
                const SizedBox(height: 10),
                getContainer(
                  width: MediaQuery.of(context).size.width / 3,
                  child: getText(
                    "Somos um banco que preza por respeito e inclusão a com nossos clientes, sempre buscando uma relação baseada inteiramente na confiança.",
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                getContainer(
                  padding: const EdgeInsets.all(10),
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(10),
                  child: getText("Conheça nossos beneficios!", fontSize: 15, bold: true),
                )
              ],
            ),
            getContainer(
              margin: const EdgeInsets.all(30),
              height: MediaQuery.of(context).size.height / 1.3,
              width: MediaQuery.of(context).size.width / 3,
              color: const Color.fromRGBO(46, 45, 39, 1),
              borderRadius: BorderRadius.circular(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 50),
                  Image.asset("assets/images/logo.png", height: 100, width: MediaQuery.of(context).size.width / 5),
                  const Spacer(),
                  getFormfield(textEditingController: cpf, hintText: "123.456.789-10", labelText: "CPF", textInputType: TextInputType.number, maskTextInputFormatter: maskFormatter),
                  getFormfield(textEditingController: nome, hintText: "Lucas Henrique", labelText: "Nome"),
                  getFormfield(textEditingController: senha, hintText: "", labelText: "Senha", obscureText: true),
                  const Spacer(),
                  _builderButtom(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
