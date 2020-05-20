import 'package:flutter/material.dart';

class FillButtonWidget extends StatelessWidget {
  final Color filledColour;
  final Function onPressed;
  final String buttonText;
  final TextStyle filledButtonStyle;

  FillButtonWidget(
      {@required this.filledColour,
      this.onPressed,
      @required this.buttonText,
      @required this.filledButtonStyle});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 120.0,
      height: 45.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: filledColour)),
        padding: EdgeInsets.all(8.0),
        onPressed: onPressed,
        color: filledColour,
        child: Text(
          buttonText,
          style: filledButtonStyle,
        ),
      ),
    );
  }
}
