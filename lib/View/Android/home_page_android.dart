// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:converter/View/Android/call_page_android.dart';
import 'package:converter/View/Android/chat_page_andriod.dart';
import 'package:converter/View/Android/setting_page_android.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Controller/Provider/app_provider.dart';
import 'add_contact_android.dart';

class home_page_android extends StatefulWidget {
  const home_page_android({super.key});

  @override
  State<home_page_android> createState() => _home_page_androidState();
}

class _home_page_androidState extends State<home_page_android> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return   DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Switch(
              value: Provider.of<AppProvider>(context).appModel.switchValue,
              onChanged: (val) {
                Provider.of<AppProvider>(context, listen: false).switchUi();
              },
            ),
          ],
          title: const Text("Platform Converter",
            style: TextStyle(fontWeight: FontWeight.bold),),
          bottom: const TabBar(
            physics: BouncingScrollPhysics(),
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            tabs: [
              Icon(Icons.person_add_alt),
              Text("CHATS"),
              Text("CALLS"),
              Text("SETTINGS"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            addContact_andriod(),
            chat_page_android(),
            call_page_android(),
            setting_page_android(),
          ],
        ),
      ),
    );
  }
}
