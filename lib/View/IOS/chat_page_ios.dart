import 'dart:io';

import 'package:converter/Controller/Provider/add_contact_provider.dart';
import 'package:converter/View/IOS/add_contact_ios.dart';
import 'package:converter/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit_page_ios.dart';

class chat_page_ios extends StatefulWidget {
  const chat_page_ios({super.key});

  @override
  State<chat_page_ios> createState() => _chat_page_iosoState();
}

class _chat_page_iosoState extends State<chat_page_ios> {
  @override
  Widget build(BuildContext context) {
    return CupertinoListSection(
      children: List.generate(
        contactList.length,
        (index) => CupertinoListTile(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          leadingSize: 80,
          leadingToTitle: 5,
          onTap: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) => Container(
                height: 350,
                width: MediaQuery.of(context).size.width,
                color: CupertinoColors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: contactList[index].xFile != null
                          ? FileImage(
                              File(contactList[index].xFile?.path ?? ""),
                            )
                          : null,
                      child: contactList[index].xFile == null
                          ? Icon(Icons.person)
                          : null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      contactList[index].name ?? 'No Name',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      contactList[index].chat ?? 'No Chat',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CupertinoButton(
                          onPressed: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => edit_page_ios(ind: index),
                            ));
                          },
                          child: const Icon(CupertinoIcons.pen),
                        ),
                        CupertinoButton(
                          onPressed: () {
                            print("Before ==> ${contactList.length}");
                            Provider.of<ContactProvider>(context, listen: false)
                                .deleteContact(index);
                            deleteContactList(index);
                            loadContactList();
                            print("After ==> ${contactList.length}");
                            Navigator.pop(context);
                          },
                          child: const Icon(CupertinoIcons.delete_solid),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CupertinoButton.filled(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel"),
                    ),
                  ],
                ),
              ),
            );
          },
          leading: CircleAvatar(
            radius: 30,
            foregroundImage:
                FileImage(File(contactList[index].xFile?.path ?? "")),
          ),
          title: Text(contactList[index].name ?? 'No Name'),
          subtitle: Text(contactList[index].chat ?? 'No Chat'),
          trailing: Text(
              "${contactList[index].selectdate?.day}-${contactList[index].selectdate?.month}-${contactList[index].selectdate?.year}/${contactList[index].selecttime?.hour}:${contactList[index].selecttime?.minute}"),
        ),
      ),
    );
  }
}
