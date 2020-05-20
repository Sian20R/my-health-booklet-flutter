import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../styles/style.dart';
import '../widgets/filled_button_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;

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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
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
                TextFormField(
                  onChanged: (value) {},
                  //validator: () {},
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.black),
                  decoration: kTextFieldInputDecoration.copyWith(
                    hintText: 'Email',
                    prefixIcon: Icon(
                      Icons.mail,
                      color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  onChanged: (value) {},
                  //validator: () {},
                  style: TextStyle(color: Colors.black),
                  obscureText: true,
                  decoration: kTextFieldInputDecoration.copyWith(
                    hintText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FillButtonWidget(
                      filledColour: Colors.green,
                      buttonText: 'Login',
                      filledButtonStyle: kLoginButtonTextStyle,
                      onPressed: () {},
                    ),
                    SizedBox(width: 15.0),
                    FillButtonWidget(
                      filledColour: Colors.red,
                      buttonText: 'Register',
                      filledButtonStyle: kRegisterButtonTextStyle,
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
      ),
    );
  }
}
