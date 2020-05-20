import 'package:flutter/material.dart';

class SnackbarWidget extends StatelessWidget {
  final String message;
  final Color backgroundColour;

  SnackbarWidget({@required this.message, @required this.backgroundColour});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(message),
      backgroundColor: backgroundColour,
    );
  }
}
