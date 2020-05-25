import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class MultiSelectFieldWidget extends StatelessWidget {
  final String titleText;
  final List dataSource;
  final String hintText;
  final Function onSaved;

  MultiSelectFieldWidget(
      {@required this.titleText,
      @required this.dataSource,
      this.hintText,
      this.onSaved});

  @override
  Widget build(BuildContext context) {
    return MultiSelectFormField(
      autovalidate: false,
      titleText: titleText,
      dataSource: dataSource,
      textField: 'display',
      valueField: 'value',
      okButtonLabel: 'OK',
      cancelButtonLabel: 'CANCEL',
      // required: true,
      hintText: hintText,
      //initialValue: dataSource,
      onSaved: onSaved,
    );
  }
}
