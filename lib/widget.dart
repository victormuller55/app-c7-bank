import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

Widget getContainer({
  double? height,
  double? width,
  BorderRadius? borderRadius,
  DecorationImage? image,
  Color? color,
  Border? border,
  Widget? child,
  EdgeInsets? padding,
  EdgeInsets? margin,
  List<BoxShadow>? boxShadow,
}) {
  return Container(
    height: height,
    width: width,
    padding: padding,
    margin: margin,
    decoration: BoxDecoration(
      borderRadius: borderRadius,
      image: image,
      color: color,
      border: border,
      boxShadow: boxShadow,
    ),
    child: child,
  );
}

Widget getText(
  String text, {
  Color? color,
  double? fontSize,
  bool? overflow,
  bool? bold,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      overflow: overflow ?? false ? TextOverflow.ellipsis : null,
      fontWeight: bold ?? false ? FontWeight.bold : null,
    ),
  );
}

Widget getButton({
  required void Function() function,
  required String text,
}) {
  return AnimatedButton(
    text: text,
    onPress: function,
    width: 400,
    borderRadius: 10,
    selectedTextColor: Colors.black,
    backgroundColor: Colors.yellow,
    transitionType: TransitionType.LEFT_CENTER_ROUNDER,
    textStyle: const TextStyle(
      fontSize: 17,
      color: Color.fromRGBO(46, 45, 39, 1),
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget getFormfield({
  required String hintText,
  required String labelText,
  required TextEditingController textEditingController,
  bool? obscureText,
  TextInputType? textInputType,
  MaskTextInputFormatter? maskTextInputFormatter,
  double? width,
}) {
  return Builder(builder: (context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        getText(labelText, color: Colors.white),
        const SizedBox(height: 5),
        SizedBox(
          width: width ?? MediaQuery.of(context).size.width / 5,
          child: TextFormField(
            inputFormatters: maskTextInputFormatter != null ? [maskTextInputFormatter] : null,
            controller: textEditingController,
            obscureText: obscureText ?? false,
            keyboardType: textInputType,
            decoration: InputDecoration(
              filled: true,
              hintText: hintText,
              fillColor: Colors.white,
              focusColor: Colors.grey.shade200,
              hoverColor: Colors.grey.shade200,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white, width: 0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white, width: 0),
              ),
            ),
          ),
        ),
      ],
    );
  });
}

Widget getLoading() {
  return Center(child: LoadingAnimationWidget.discreteCircle(color: Colors.yellow, size: 40));
}

SnackBar getGenericSnackBar(
  BuildContext context, {
  required String message,
  required Color color,
  required Color buttonColor,
}) {
  return SnackBar(
    content: getText(message),
    backgroundColor: color,
    action: SnackBarAction(
      label: 'Fechar',
      onPressed: () => ScaffoldMessenger.of(context).clearSnackBars(),
      backgroundColor: buttonColor,
      textColor: Colors.white,
    ),
  );
}

SnackBar getSnackBarError(BuildContext context) {
  return getGenericSnackBar(
    context,
    message: "Ocorreu um erro durante a operação, tente novamente mais tarde!",
    color: Colors.red,
    buttonColor: Colors.red.shade700,
  );
}

SnackBar getSnackBarWarning(BuildContext context, {required String message}) {
  return getGenericSnackBar(
    context,
    message: message,
    color: Colors.orange,
    buttonColor: Colors.orange.shade700,
  );
}

SnackBar getSnackBarSucess(BuildContext context, {required String message}) {
  return getGenericSnackBar(
    context,
    message: message,
    color: Colors.green,
    buttonColor: Colors.green.shade700,
  );
}
