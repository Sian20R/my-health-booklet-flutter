import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../styles/style.dart';
import '../utils/validation.dart';
import '../widgets/filled_button_widget.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.book),
        title: Text('Registration'),
        backgroundColor: Colors.green,
      ),
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
                        height: 180.0,
                      ),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) => email = value,
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
                    onChanged: (value) => password = value,
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
                  SizedBox(height: 10.0),
                  TextFormField(
                    onChanged: (value) {},
                    validator: (val) =>
                        MatchValidator(errorText: 'passwords do not match')
                            .validateMatch(val, password),
                    style: TextStyle(color: Colors.black),
                    obscureText: true,
                    decoration: kTextFieldInputDecoration.copyWith(
                      hintText: 'Confirm Password',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FillButtonWidget(
                        filledColour: Colors.green,
                        buttonText: 'Register',
                        filledButtonStyle: kLoginButtonTextStyle,
                        onPressed: registerAction,
                      ),
                      SizedBox(width: 15.0),
                      FillButtonWidget(
                        filledColour: Colors.red,
                        buttonText: 'Cancel',
                        filledButtonStyle: kRegisterButtonTextStyle,
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void registerAction() async {
    setState(() => showSpinner = true);
    if (_formKey.currentState.validate()) {
      try {
        final newUser = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        if (newUser != null) {
          Navigator.pop(context, 'User created Successfully!');
        }
      } catch (e) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Unable to create user'),
          ),
        );
      }
    }

    setState(() => showSpinner = false);
  }
}
