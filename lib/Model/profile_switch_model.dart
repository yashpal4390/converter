import 'dart:io';

import 'package:flutter/cupertino.dart';

class ProfileModel {
  bool profileSwitch;
  File userImage;
  TextEditingController userName;
  TextEditingController userBio;

  ProfileModel({
    required this.profileSwitch,
    required this.userImage,
    required this.userName,
    required this.userBio,
  });
}
