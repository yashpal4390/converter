import 'package:converter/View/Android/call_page_android.dart';
import 'package:converter/View/IOS/add_contact_ios.dart';
import 'package:converter/View/IOS/call_page_ios.dart';
import 'package:converter/View/IOS/chat_page_ios.dart';
import 'package:converter/View/IOS/setting_page_ios.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controller/Provider/app_provider.dart';

class home_page_ios extends StatefulWidget {
  const home_page_ios({super.key});

  @override
  State<home_page_ios> createState() => _home_page_iosState();
}

class _home_page_iosState extends State<home_page_ios> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: Colors.white,
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_add),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_2),
            label: "CHATS",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.phone),
            label: "CALLS",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: "SETTINGS",
          ),
        ],
      ),
      tabBuilder: (context, i) {
        return CupertinoTabView(
          builder: (context) {
            return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: const Text(
                  "Platform Converter",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                trailing: CupertinoSwitch(
                  value: Provider.of<AppProvider>(context).appModel.switchValue,
                  onChanged: (val) {
                    Provider.of<AppProvider>(context, listen: false).switchUi();
                  },
                ),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    IndexedStack(
                      index: i,
                      children:  [
                        add_contact_ios(),
                        chat_page_ios(),
                        call_page_ios(),
                        setting_page_ios(),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
