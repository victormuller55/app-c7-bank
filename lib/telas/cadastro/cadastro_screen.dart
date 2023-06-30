import 'package:app_c7_bank/model/model_cadastro.dart';
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

  CadastroBloc bloc = CadastroBloc();

  TextEditingController nome = TextEditingController();
  TextEditingController cpf = TextEditingController();
  TextEditingController senha = TextEditingController();

  MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  void _salvarCliente() {
    if (nome.text.isNotEmpty && cpf.text.isNotEmpty && senha.text.isNotEmpty) {
      ClienteModel clienteModel = ClienteModel(nomeCliente: nome.value.text, cpfCliente: cpf.value.text, senhaCliente: senha.value.text);
      bloc.add(CadastroSalvarEvent(clienteModel));
      setState(() {});
    } else {
      showSnackBarWarning(context, message: "Todos os campos são obrigatórios");
    }
  }

  void _onChangeState(CadastroState state) {
    if (state is CadastroErrorState) showSnackBarError(context);
    if (state is CadastroErrorState) setState(() {});
    if (state is CadastroSuccessState) showSnackBarSucess(context, message: "Conta criada com sucesso");
    if (state is CadastroSuccessState) Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(model: state.contaModel, nomeCliente: nome.text)));
  }

  Widget _botao() {
    return AnimatedButton(
      width: MediaQuery.of(context).size.width / 3,
      text: bloc.state is CadastroLoadingState ? "ENVIANDO DADOS..." : 'CADASTRAR',
      selectedTextColor: Colors.black,
      backgroundColor: Colors.yellow,
      borderRadius: 10,
      transitionType: TransitionType.LEFT_CENTER_ROUNDER,
      textStyle: const TextStyle(fontSize: 17, color: Color.fromRGBO(46, 45, 39, 1), fontWeight: FontWeight.bold),
      onPress: () => _salvarCliente(),
    );
  }

  Widget _body() {
    return getContainer(
      colorsGradient: [
        const Color.fromRGBO(37, 36, 33, 1),
        const Color.fromRGBO(21, 21, 20, 1),
      ],
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
                child: getText("Somos um banco que preza por respeito e inclusão a com nossos clientes, sempre buscando uma relação baseada inteiramente na confiança.", color: Colors.white, fontSize: 20),
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
    );
  }

  Widget _builderButtom() {
    return BlocConsumer<CadastroBloc, CadastroState>(
      bloc: bloc,
      listener: (context, state) => _onChangeState(state),
      builder: (context, state) => _botao(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: bloc.state is CadastroLoadingState ? LoadingAnimationWidget.discreteCircle(color: Colors.yellow, size: 40) : null,
      body: _body(),
    );
  }
}
