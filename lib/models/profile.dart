import 'dart:io';
import 'package:flutter/cupertino.dart';

class Profile {
  String name;
  String email;
  String dateOfBirth;
  String gender;
  List diseases;
  File profilePicture;
  String profilePicturePath;

  Profile(
      {@required this.name,
      @required this.email,
      @required this.dateOfBirth,
      @required this.gender,
      this.diseases,
      this.profilePicture,
      this.profilePicturePath});
}
