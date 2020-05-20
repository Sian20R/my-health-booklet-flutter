import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:myhealthbooklet/screens/registration_screen.dart';
import '../constants.dart';
import '../styles/style.dart';
import '../utils/validation.dart';
import '../widgets/filled_button_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
      key: _scaffoldKey,
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
            child: Form(
              key: _formKey,
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
                    validator: emailValidator,
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
                    validator: passwordValidator,
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
                        onPressed: () {
                          _formKey.currentState.validate();
                        },
                      ),
                      SizedBox(width: 15.0),
                      FillButtonWidget(
                        filledColour: Colors.red,
                        buttonText: 'Register',
                        filledButtonStyle: kRegisterButtonTextStyle,
                        onPressed: () => _navigateAndDisplaySelection(context),
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
      ),
    );
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => RegistrationScreen()),
    );

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    _scaffoldKey.currentState
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(result),
          backgroundColor: Colors.green,
        ),
      );

    FocusScope.of(_scaffoldKey.currentContext).unfocus();
  }
}
