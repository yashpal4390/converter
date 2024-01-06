import 'dart:io';
import 'package:converter/Controller/Provider/add_contact_provider.dart';
import 'package:converter/View/Android/home_page_android.dart';
import 'package:converter/View/IOS/home_page_ios.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Controller/Provider/app_provider.dart';
import 'Controller/Provider/profile_provider.dart';
import 'Controller/Provider/theme_provider.dart';
import 'Model/app_model.dart';
import 'Model/profile_switch_model.dart';
import 'Model/theme_model.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  bool profileSwitch = prefs.getBool('profileSwitch') ?? false;
  String userImage = prefs.getString('userImage') ?? '';
  String userName = prefs.getString('userName') ?? '';
  String userBio = prefs.getString('userBio') ?? '';
  bool appSwitch = prefs.getBool('appSwitch') ?? false;

  bool appTheme = prefs.getBool('AppTheme') ?? false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(
            themeModel: ThemeModel(
              isDark: appTheme,
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(
            profileModel: ProfileModel(
              profileSwitch: profileSwitch,
              userImage: File(userImage),
              userName: TextEditingController(text: userName),
              userBio: TextEditingController(text: userBio),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => AppProvider(
            appModel: AppModel(
              switchValue: appSwitch,
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) {
            return ContactProvider();
          },
        ),
      ],
      builder: (context, child) {
        return (Provider.of<AppProvider>(context).appModel.switchValue == false)?
            MaterialApp(
          darkTheme: ThemeData.dark(
            useMaterial3: true,
          ),
          theme: ThemeData.light(
            useMaterial3: true,
          ),
          themeMode: (Provider.of<ThemeProvider>(context).themeModel.isDark)
              ? ThemeMode.dark
              : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const home_page_android(),
          },
        ): CupertinoApp(
          theme: CupertinoThemeData(
            brightness:
            (Provider.of<ThemeProvider>(context).themeModel.isDark)
                ? Brightness.dark
                : Brightness.light,
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => home_page_ios(),
          },
        );
      },
    ),
  );
}
