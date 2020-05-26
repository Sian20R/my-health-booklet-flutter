import 'dart:io';
import 'package:flutter/foundation.dart';
import '../models/profile.dart';

class ProfileState with ChangeNotifier {
  Profile _profile = Profile();

  void setProfile(Profile profile) {
    _profile = profile;
    notifyListeners();
  }

  void setProfilePicture(File profilePicture) {
    _profile.profilePicture = profilePicture;
    notifyListeners();
  }

  void setEmail(String email) {
    _profile.email = email;
    notifyListeners();
  }

  Profile getProfile() {
    return _profile;
  }
}
