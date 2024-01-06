import 'dart:io';
import 'package:converter/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Controller/Provider/add_contact_provider.dart';

class call_page_ios extends StatefulWidget {
  const call_page_ios({super.key});

  @override
  State<call_page_ios> createState() => _call_page_iosState();
}

class _call_page_iosState extends State<call_page_ios> {
  @override
  Widget build(BuildContext context) {
    return CupertinoListSection(
      children: List.generate(
        contactList.length,
        (index) => CupertinoListTile(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          leadingSize: 80,
          leadingToTitle: 5,
          leading: CircleAvatar(
            radius: 30,
            foregroundImage: FileImage(
              File(contactList[index].xFile?.path ?? ""),
            ),
          ),
          title: Text(contactList[index].name ?? 'No Name'),
          subtitle: Text(contactList[index].chat ?? 'No Chat'),
          trailing: CupertinoButton(
            onPressed: () async {
              Uri uri = Uri.parse("tel:+91${contactList[index].number}");
              try {
                await launchUrl(uri);
              } catch (e) {
                print("Exception : $e");
              }
            },
            child: const Icon(
              CupertinoIcons.phone,
              color: CupertinoColors.activeBlue,
            ),
          ),
        ),
      ),
    );
  }
}
