import 'package:flutter/material.dart';

class OutlineButtonWidget extends StatelessWidget {
  final Color outlineColour;
  final Function onPressed;
  final String buttonText;
  final TextStyle outlineButtonStyle;

  OutlineButtonWidget(
      {@required this.outlineColour,
      this.onPressed,
      @required this.buttonText,
      @required this.outlineButtonStyle});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      minWidth: 120.0,
      height: 45.0,
      child: OutlineButton(
        onPressed: onPressed,
        borderSide: BorderSide(
          color: outlineColour,
          style: BorderStyle.solid,
          width: 1.8,
        ),
        child: Text(buttonText, style: outlineButtonStyle),
      ),
    );
  }
}
