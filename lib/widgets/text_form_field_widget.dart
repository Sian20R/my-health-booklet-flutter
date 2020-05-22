import 'package:flutter/material.dart';
import '../styles/style.dart';

class TextFormFieldWidget extends StatelessWidget {
  final Function onChanged;
  final FormFieldValidator validator;
  final TextInputType keyBoardType;
  final Function onTap;
  final bool isPassword;
  final String hintText;
  final IconData icon;
  final TextEditingController controller;

  TextFormFieldWidget(
      {this.onChanged,
      this.validator,
      this.keyBoardType,
      this.onTap,
      this.hintText,
      this.icon,
      this.controller,
      this.isPassword});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (onChanged != null) ? onChanged : null,
      validator: (validator != null) ? validator : null,
      onTap: (onTap != null) ? onTap : null,
      controller: (controller != null) ? controller : null,
      keyboardType: (keyBoardType != null) ? keyBoardType : null,
      style: TextStyle(color: Colors.black),
      obscureText: (isPassword != null) ? isPassword : false,
      decoration: kTextFieldInputDecoration.copyWith(
        hintText: hintText,
        prefixIcon: Icon(
          icon,
          color: Colors.black54,
        ),
      ),
    );
  }
}
