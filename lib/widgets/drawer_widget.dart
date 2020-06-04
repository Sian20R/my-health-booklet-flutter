import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import '../constants.dart';
import '../states/profile_state.dart';
import '../models/profile.dart';

final _fireBaseAuth = FirebaseAuth.instance;
final GoogleSignIn _googleAuth = GoogleSignIn();
final _facebookAuth = FacebookLogin();
final _fireStore = Firestore.instance;
FirebaseUser loggedInUser;

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String profilePicturePath;
  String name = '';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        setState(() {
          email = loggedInUser.email;
          _fireStore
              .collection("users")
              .where('email', isEqualTo: email)
              .snapshots()
              .listen((value) {
            value.documents.forEach((doc) {
              profilePicturePath = doc['profilePicturePath'];
              name = doc['name'];
              Profile profile = Profile(
                email: email,
                name: name,
                dateOfBirth: doc['dateOfBirth'],
                diseases: doc['diseases'],
                gender: doc['gender'],
                profilePicturePath: profilePicturePath,
              );

              Provider.of<ProfileState>(context, listen: false)
                  .setProfile(profile);
            });
          });
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text(
              email,
              style: TextStyle(color: Colors.black54),
            ),
            accountName: Text(
              name,
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w800,
                  fontSize: 20.0),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: (profilePicturePath == null)
                  ? AssetImage("images/user.png")
                  : NetworkImage(profilePicturePath),
              radius: 30.0,
              backgroundColor: Colors.white,
            ),
            decoration: BoxDecoration(
              color: Colors.green,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.green,
            ),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.pushNamed(context, RouteConstant.home);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.account_box,
              color: Colors.blue,
            ),
            title: Text(
              'Profile',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.pushNamed(context, RouteConstant.profile);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.local_hospital,
              color: Colors.red,
            ),
            title: Text(
              'Diseases',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.pushNamed(context, RouteConstant.diseases);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.score,
              color: Colors.yellow,
            ),
            title: Text(
              'Diagnose',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.chat,
              color: Colors.purple,
            ),
            title: Text(
              'Chat',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.highlight_off,
              color: Colors.orange,
            ),
            title: Text(
              'Sign Out',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () async {
              await signOut();
              Navigator.pushNamed(context, RouteConstant.login);
              //Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<Null> signOut() async {
    // Sign out with firebase
    await _fireBaseAuth.signOut();
    // Sign out with google
    await _googleAuth.signOut();
    // Sign out with facebook
    await _facebookAuth.logOut();
  }
}
