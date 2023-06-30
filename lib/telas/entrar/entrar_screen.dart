import 'package:app_c7_bank/telas/cadastro/cadastro_screen.dart';
import 'package:app_c7_bank/telas/entrar/entrar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:app_c7_bank/model/model_cadastro.dart';
import 'package:app_c7_bank/telas/cadastro/cadastro_bloc.dart';
import 'package:app_c7_bank/telas/cadastro/cadastro_event.dart';
import 'package:app_c7_bank/telas/cadastro/cadastro_state.dart';
import 'package:app_c7_bank/telas/home/home_screen.dart';
import 'package:app_c7_bank/widget.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'entrar_event.dart';
import 'entrar_state.dart';

class EntrarScreen extends StatefulWidget {
  const EntrarScreen({Key? key}) : super(key: key);

  @override
  State<EntrarScreen> createState() => _EntrarScreenState();
}

class _EntrarScreenState extends State<EntrarScreen> {

  EntrarBloc bloc = EntrarBloc();

  TextEditingController numero = TextEditingController();
  TextEditingController agencia = TextEditingController();
  TextEditingController senha = TextEditingController();

  void _salvarCliente() {
    if (numero.text.isNotEmpty && agencia.text.isNotEmpty && senha.text.isNotEmpty) {
      bloc.add(EntrarEntrarEvent(numero: numero.text, agencia: agencia.text, senha: senha.text));
      setState(() {});
    } else {
      showSnackBarWarning(context, message: "Todos os campos são obrigatórios");
    }
  }

  void _onChangeState(EntrarState state) {
    if (state is EntrarErrorState) showSnackBarError(context);
    if (state is EntrarErrorState) setState(() {});
    if (state is EntrarSuccessState) showSnackBarSucess(context, message: "Login realizado com sucesso");
    if (state is EntrarSuccessState) Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(model: state.contaModel, nomeCliente: "Cliente")));
  }

  Widget _botao() {
    return AnimatedButton(
      width: MediaQuery.of(context).size.width / 3,
      text: bloc.state is CadastroLoadingState ? "PROCURANDO CONTA..." : 'ENTRAR',
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
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      colorsGradient: [
        const Color.fromRGBO(37, 36, 33, 1),
        const Color.fromRGBO(21, 21, 20, 1),
      ],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getContainer(
            margin: const EdgeInsets.all(30),
            width: MediaQuery.of(context).size.width / 3,
            color: const Color.fromRGBO(46, 45, 39, 1),
            borderRadius: BorderRadius.circular(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 50),
                Image.asset("assets/images/logo.png", height: 100, width: MediaQuery.of(context).size.width / 5),
                const Spacer(),
                const SizedBox(height: 40),
                getText("ENTRAR",  color: Colors.yellow, bold: true, fontSize: 23),
                const SizedBox(height: 20),
                getFormfield(textEditingController: numero, hintText: "1234567-8", labelText: "Número", textInputType: TextInputType.number),
                getFormfield(textEditingController: agencia, hintText: "1238", labelText: "Agencia"),
                getFormfield(textEditingController: senha, hintText: "", labelText: "Senha", obscureText: true),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getText("Não tem conta?   ",  color: Colors.white),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CadastroScreen())),
                      child: getText("CADASTRAR",  color: Colors.yellow, bold: true),
                    ),
                  ],
                ),
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
    return BlocConsumer<EntrarBloc, EntrarState>(
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

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
