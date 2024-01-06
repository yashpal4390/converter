import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../util.dart';
import 'add_contact_android.dart';

class call_page_android extends StatefulWidget {
  const call_page_android({super.key});

  @override
  State<call_page_android> createState() => _call_page_androidState();
}

class _call_page_androidState extends State<call_page_android> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contactList.length,
      itemBuilder: (context, index) => ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        horizontalTitleGap: 10,
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: contactList[index].xFile != null
              ? FileImage(
            File(contactList[index].xFile?.path ?? ""),
          )
              : null,
        ),
        title: Text(contactList[index].name ?? 'No Name'),
        subtitle: Text(contactList[index].chat ?? 'No Chat'),
        trailing: IconButton(
          onPressed: () async {

            Uri uri = Uri.parse(
                "tel:+91${contactList[index].number}");
            try {
              await launchUrl(uri);
            } catch (e) {
              print("Exception : $e");
            }
          },
          icon: const Icon(
            Icons.phone,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
