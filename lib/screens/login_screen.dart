import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../constants.dart';
import '../screens/registration_screen.dart';
import '../styles/style.dart';
import '../utils/validation.dart';
import '../widgets/filled_button_widget.dart';
import '../widgets/text_form_field_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleAuth = GoogleSignIn();

  bool showSpinner = false;
  String email;
  String password;
  List<GestureDetector> socialMediaLogins = [];

  @override
  void initState() {
    super.initState();
    socialMediaLogins = [
      GestureDetector(
        onTap: () => loginWithGoogle(),
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
  }

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
                  TextFormFieldWidget(
                    onChanged: (value) => email = value,
                    validator: emailValidator,
                    keyBoardType: TextInputType.emailAddress,
                    hintText: 'Email',
                    icon: Icons.mail,
                  ),
                  SizedBox(height: 10.0),
                  TextFormFieldWidget(
                    onChanged: (value) => password = value,
                    validator: passwordValidator,
                    isPassword: true,
                    hintText: 'Password',
                    icon: Icons.lock,
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FillButtonWidget(
                        filledColour: Colors.green,
                        buttonText: 'Login',
                        filledButtonStyle: kLoginButtonTextStyle,
                        onPressed: loginWithEmailAndPassword,
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

  // Methods
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

  void loginWithEmailAndPassword() async {
    setState(() => showSpinner = true);
    if (_formKey.currentState.validate()) {
      try {
        final newUser = await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        if (newUser != null) {
          Navigator.pushNamed(context, RouteConstant.home);
        }
      } catch (e) {
        _scaffoldKey.currentState
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Error logging in'),
              backgroundColor: Colors.red,
            ),
          );
      }
    }
    setState(() => showSpinner = false);
  }

  void loginWithGoogle() async {
    setState(() => showSpinner = true);

    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleAuth.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult authResult =
          await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      if (user != null) {
        Navigator.pushNamed(context, RouteConstant.home);
      }
    } catch (e) {
      _scaffoldKey.currentState
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('Error logging in'),
            backgroundColor: Colors.red,
          ),
        );

      print(e);
    }

    setState(() => showSpinner = false);
  }
}
