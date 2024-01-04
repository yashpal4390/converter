// ignore_for_file: sort_child_properties_last, prefer_const_constructors
import 'dart:io';
import 'package:converter/Controller/Provider/add_contact_provider.dart';
import 'package:converter/View/Android/add_contact_android.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Model/ShredPrefrencesHelper.dart';
import '../../Model/add_contact_model.dart';
import '../../main.dart';

class chat_page_android extends StatefulWidget {
  chat_page_android({super.key});

  @override
  State<chat_page_android> createState() => _chat_page_androidState();
}

class _chat_page_androidState extends State<chat_page_android> {
  @override
  void initState() {
    super.initState();
    loadContactList();
  }

  Future<void> loadContactList() async {
    List<ContactModal> loadedList =
        await SharedPreferencesHelper.getContactList();
    setState(() {
      contactList = loadedList;
    });
  }

  Future<void> saveContactList() async {
    await SharedPreferencesHelper.saveContactList(contactList);
  }

  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(
        builder: (context, contactprovider, child) {
      return ListView.builder(
        itemCount: contactList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              var cp = Provider.of<ContactProvider>(context, listen: false);
              showBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    height: MediaQuery.sizeOf(context).height * 0.4,
                    width: MediaQuery.sizeOf(context).width * 1,
                    color: Colors.grey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: CircleAvatar(
                            backgroundImage: contactList[index].xFile != null
                                ? FileImage(
                                    File(contactList[index].xFile?.path ?? ""),
                                  )
                                : null,
                            child: contactList[index].xFile == null
                                ? Icon(
                                    Icons.person,
                                    size: 40,
                                  )
                                : null,
                            maxRadius: 60,
                          ),
                        ),
                        Text(contactList[index].name ?? 'No Name'),
                        Text(
                          "${contactList[index].name}",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "${contactList[index].chat}",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  contactprovider.deleteContact(index);
                                },
                                child: Icon(Icons.delete),
                              ),
                              InkWell(
                                onTap: () {
                                  ContactModal cm = ContactModal(
                                      name: cp.nameController.text,
                                      number: cp.phoneController.text,
                                      chat: cp.chatController.text,
                                      selectdate: cp.selectdate,
                                      selecttime: cp.selecttime,
                                      xFile: cp.xFile);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => addContact_andriod(
                                        index: index,
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(Icons.edit),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: contactList[index].xFile != null
                    ? FileImage(
                        File(contactList[index].xFile?.path ?? ""),
                      )
                    : null,
                child: contactList[index].xFile == null
                    ? Icon(Icons.person)
                    : null,
              ),
              title: Text(contactList[index].name ?? 'No Name'),
              subtitle: Text(contactList[index].chat ?? 'No Chat'),
              trailing: Text(
                  "${contactList[index].selectdate?.day}-${contactList[index].selectdate?.month}-${contactList[index].selectdate?.year}/${contactList[index].selecttime?.hour}:${contactList[index].selecttime?.minute}"),
            ),
          );
        },
      );
    });
  }
}
