import 'dart:io';
import 'package:flutter/cupertino.dart';

class Profile {
  String name;
  String dateOfBirth;
  String gender;
  List<String> diseases;
  File profilePicture;
  String profilePicturePath;

  Profile(
      {@required this.name,
      @required this.dateOfBirth,
      @required this.gender,
      this.diseases,
      this.profilePicture,
      this.profilePicturePath});
}
