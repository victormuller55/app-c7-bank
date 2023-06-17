import 'package:flutter/material.dart';

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
    ),
    child: child,
  );
}

Widget getText(String text, {Color? color, double? fontSize, bool? overflow, bool? bold}) {
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

Widget getFormfield({
  required String hintText,
  required TextEditingController textEditingController,
  bool? obscureText,
  TextInputType? textInputType,
}) {
  return Builder(builder: (context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        getText(hintText, color: Colors.white),
        const SizedBox(height: 5),
        SizedBox(
          width: MediaQuery.of(context).size.width / 5,
          child: TextFormField(
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
