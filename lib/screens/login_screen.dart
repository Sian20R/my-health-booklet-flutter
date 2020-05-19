import 'package:flutter/material.dart';
import '../styles/style.dart';

class LoginScreen extends StatelessWidget {
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset(
                      'images/app_logo.png',
                      scale: 0.6,
                    ),
                  ),
                ),
              ),
              Text(
                'My Health Booklet',
                textAlign: TextAlign.center,
                style: kLogoTitleTextStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
