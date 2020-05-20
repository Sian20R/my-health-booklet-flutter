import 'package:flutter/material.dart';

const kLoginButtonTextStyle = TextStyle(
  color: Colors.black54,
  fontFamily: 'Roboto Black',
  fontWeight: FontWeight.w500,
  fontSize: 15.0,
);

const kRegisterButtonTextStyle = TextStyle(
  color: Colors.black54,
  fontFamily: 'Roboto Black',
  fontWeight: FontWeight.w500,
  fontSize: 15.0,
);

const kTextFieldInputDecoration = InputDecoration(
  hintText: 'Enter a value',
  fillColor: Colors.white,
  hintStyle: TextStyle(fontSize: 12.0, color: Colors.black54),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
    borderSide: BorderSide(),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black54, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black54, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
