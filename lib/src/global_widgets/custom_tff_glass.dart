import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/src/core/constants/colors.dart';

class CustomTextFormFieldGlass extends StatelessWidget {
  final Function(String value)? onSaved;
  final Function(String value)? onChanged;
  final Function(String value)? validator;
  final bool? emailCheck;
  final String? text;
  final Widget? sufixIcon;
  final Widget? prefixIcon;
  final TextInputAction? action;
  final TextInputType? type;
  final bool? obscure;
  final TextEditingController? controller;
  final TextDirection? direction;
  final int? max;
  final dynamic formatter;
  final int? maxLines;
  final String? initialValue;
  final String? hintText;

  const CustomTextFormFieldGlass(
      {Key? key, this.maxLines = 1,
      this.initialValue,
      this.emailCheck,
      this.text,
      this.formatter = const <TextInputFormatter>[],
      this.onChanged,
      this.onSaved,
      this.validator,
      this.sufixIcon,
      this.action,
      this.type,
      this.obscure = false,
      this.controller,
      this.direction = TextDirection.ltr,
      this.max,
      this.prefixIcon,
      this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: formatter,
      maxLines: maxLines,
      initialValue: initialValue,
      maxLength: max,
      textDirection: direction,
      controller: controller,
      obscureText: obscure!,
      style: const TextStyle(fontSize: 16, color: Colors.white),
      keyboardType: type,
      cursorColor: neruColor2,
      decoration: InputDecoration(
          labelStyle: const TextStyle(color: Colors.white),
          focusColor: Colors.white,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          //contentPadding: EdgeInsets.only(top: 5),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.white,
          )),
          labelText: text,
          suffixIcon: sufixIcon,
          prefixIcon: prefixIcon),
      onChanged: (value) => onChanged!(value),
      onSaved: (value) => onSaved!(value!),
      validator: (value) => validator!(value!),
      textInputAction: action,
    );
  }
}
