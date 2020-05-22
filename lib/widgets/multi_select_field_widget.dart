import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class MultiSelectFieldWidget extends StatelessWidget {
  final String titleText;
  final List dataSource;
  final String hintText;

  MultiSelectFieldWidget(
      {@required this.titleText, @required this.dataSource, this.hintText});

  @override
  Widget build(BuildContext context) {
    return MultiSelectFormField(
      autovalidate: false,
      titleText: titleText,
      dataSource: [
        {
          "display": "Running",
          "value": "Running",
        },
        {
          "display": "Climbing",
          "value": "Climbing",
        },
        {
          "display": "Walking",
          "value": "Walking",
        },
        {
          "display": "Swimming",
          "value": "Swimming",
        },
        {
          "display": "Soccer Practice",
          "value": "Soccer Practice",
        },
        {
          "display": "Baseball Practice",
          "value": "Baseball Practice",
        },
        {
          "display": "Football Practice",
          "value": "Football Practice",
        },
      ],
      textField: 'display',
      valueField: 'value',
      okButtonLabel: 'OK',
      cancelButtonLabel: 'CANCEL',
      // required: true,
      hintText: hintText,
      //initialValue: dataSource,
    );
  }
}
