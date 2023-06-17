import 'package:app_c7_bank/telas/cadastro/cadastro_bloc.dart';
import 'package:app_c7_bank/telas/cadastro/cadastro_event.dart';
import 'package:app_c7_bank/telas/cadastro/cadastro_model.dart';
import 'package:app_c7_bank/telas/cadastro/cadastro_state.dart';
import 'package:app_c7_bank/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void _salvarCliente() {
    ClienteModel clienteModel = ClienteModel(nomeCliente: nome.text, cpfCliente: cpf.text, senhaCliente: senha.text);
    cadastroBloc.add(CadastroSalvarEvent(clienteModel));
  }

  Widget _botao(bool loading) {
    return ElevatedButton(
      onPressed: () => _salvarCliente(),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width / 3, 45),
        backgroundColor: Colors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: loading ? const CircularProgressIndicator() : getText("CADASTRAR", fontSize: 20, bold: true, color: Colors.black),
    );
  }

  Widget _builderButtom() {
    return BlocBuilder<CadastroBloc, CadastroState>(
      bloc: cadastroBloc,
      builder: (context, state) {
        switch (state.runtimeType) {
          case CadastroLoadingState:
            return _botao(true);

          default:
            return _botao(false);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(37, 36, 33, 1),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     getText("Por que escolher o ", color: Colors.white, fontSize: 48, bold: true),
          //     const SizedBox(height: 10),
          //     getText("C7 Bank?", color: Colors.yellow, fontSize: 48, bold: true),
          //     const SizedBox(height: 10),
          //     getContainer(
          //       width: MediaQuery.of(context).size.width / 3,
          //       child: getText("Somos um banco que preza por respeito e inclusão a com nossos clientes, sempre buscando uma relação baseada inteiramente na confiança.", color: Colors.white, fontSize: 30),
          //     ),
          //     const SizedBox(height: 20),
          //     getContainer(
          //       padding: const EdgeInsets.all(10),
          //       color: Colors.yellow,
          //       borderRadius: BorderRadius.circular(10),
          //       child: getText("Conheça nossos beneficios!", fontSize: 20, bold: true),
          //     )
          //   ],
          // ),
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
                getFormfield(textEditingController: cpf, hintText: "Digite seu CPF", textInputType: TextInputType.number),
                getFormfield(textEditingController: nome, hintText: "Digite seu nome"),
                getFormfield(textEditingController: senha, hintText: "Digite a senha", obscureText: true),
                const Spacer(),
                _builderButtom(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
