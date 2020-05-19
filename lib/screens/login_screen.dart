import 'package:flutter/material.dart';
import 'package:myhealthbooklet/styles/style.dart';
import '../widgets/outline_button_widget.dart';

class LoginScreen extends StatelessWidget {
  List<GestureDetector> socialMediaLogins = [
    GestureDetector(
      onTap: () {},
      child: Image.asset('images/google_logo.png'),
    ),
    GestureDetector(
      onTap: () {},
      child: Image.asset('images/facebook_logo.png'),
    ),
    GestureDetector(
      onTap: () {},
      child: Image.asset('images/windows_logo.png'),
    ),
    GestureDetector(
      onTap: () {},
      child: Image.asset('images/apple_logo.png'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset(
                      'images/app_logo.png',
                    ),
                    height: 250.0,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OutlineButtonWidget(
                    outlineColour: Colors.green,
                    buttonText: 'Login',
                    outlineButtonStyle: kLoginButtonTextStyle,
                    onPressed: () {},
                  ),
                  SizedBox(width: 15.0),
                  OutlineButtonWidget(
                    outlineColour: Colors.red,
                    buttonText: 'Register',
                    outlineButtonStyle: kRegisterButtonTextStyle,
                    onPressed: () {},
                  )
                ],
              ),
              SizedBox(height: 15.0),
              Text(
                'OR',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: socialMediaLogins,
              )
            ],
          ),
        ),
      ),
    );
  }
}
