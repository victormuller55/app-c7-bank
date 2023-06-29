import 'package:app_c7_bank/telas/cadastro/cadastro_screen.dart';
import 'package:app_c7_bank/telas/home/home_screen.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // theme: ThemeData(
      //   useMaterial3: true,
      // ),
      home: CadastroScreen(),
    );
  }
}
