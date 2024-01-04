import 'dart:io';

import 'package:converter/Controller/Provider/add_contact_provider.dart';
import 'package:converter/Model/add_contact_model.dart';
import 'package:converter/View/Android/home_page_android.dart';
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
  prefs=await SharedPreferences.getInstance();
  // SharedPreferences prefs = await SharedPreferences.getInstance();


  List<String> image = prefs.getStringList('image') ?? [];
  List<String> fullName = prefs.getStringList('fullName') ?? [];
  List<String> phoneNumber = prefs.getStringList('phoneNumber') ?? [];
  List<String> chatConversation = prefs.getStringList('chatConversation') ?? [];
  List<String> date = prefs.getStringList('date') ?? [];
  List<String> time = prefs.getStringList('time') ?? [];

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
        return
            // Android IOS Condition Applied Here
            MaterialApp(
          darkTheme: ThemeData.dark(
            useMaterial3: true,
          ),
          theme: ThemeData.light(
            useMaterial3: true,
          ),
          themeMode:
          (Provider.of<ThemeProvider>(context).themeModel.isDark)
              ? ThemeMode.dark
              : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const homepage(),
          },
        );
      },
    ),
  );
}
