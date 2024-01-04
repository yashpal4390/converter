// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:converter/View/Android/call_page_android.dart';
import 'package:converter/View/Android/chat_page_andriod.dart';
import 'package:converter/View/Android/setting_page_android.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Controller/Provider/app_provider.dart';
import 'add_contact_android.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
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
