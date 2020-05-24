import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'states/profile_state.dart';
import 'constants.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/image_upload_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProfileState(),
        ),
      ],
      child: MaterialApp(
        title: 'My Health Booklet',
        theme: ThemeData.light().copyWith(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            //dialogBackgroundColor: Colors.black,
            textTheme: Typography(platform: TargetPlatform.android).black),
        initialRoute: RouteConstant.login,
        routes: {
          RouteConstant.login: (context) => LoginScreen(),
          RouteConstant.register: (context) => RegistrationScreen(),
          RouteConstant.home: (context) => HomeScreen(),
          RouteConstant.profile: (context) => ProfileScreen(),
          RouteConstant.uploadProfilePicture: (context) => ImageUploadScreen(),
        },
      ),
    );
  }
}
