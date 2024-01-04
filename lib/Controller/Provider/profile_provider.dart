import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/profile_switch_model.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel profileModel;

  ProfileProvider({required this.profileModel});

  changeProfileSwitchValue() async {
    profileModel.profileSwitch = !profileModel.profileSwitch;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('profileSwitch', profileModel.profileSwitch);

    notifyListeners();
  }

  pickImage() async {
    ImagePicker pick = ImagePicker();
    XFile? img = await pick.pickImage(source: ImageSource.camera);

    profileModel.userImage = File(img!.path);
    notifyListeners();
  }

  saveDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('userImage', profileModel.userImage.path);
    prefs.setString('userName', profileModel.userName.text);
    prefs.setString('userBio', profileModel.userBio.text);

    notifyListeners();
  }

  clearDetails() async {
    profileModel.userName.clear();
    profileModel.userBio.clear();
    profileModel.userImage = File('');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('userImage', profileModel.userImage.path);
    prefs.setString('userName', profileModel.userName.text);
    prefs.setString('userBio', profileModel.userBio.text);

    notifyListeners();
  }
}
