import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/app_model.dart';

class AppProvider extends ChangeNotifier {
  AppModel appModel;

  AppProvider({required this.appModel});

  switchUi() async {
    appModel.switchValue = !appModel.switchValue;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('appSwitch', appModel.switchValue);
    notifyListeners();
  }
}
