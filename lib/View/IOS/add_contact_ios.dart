// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:converter/Controller/Provider/add_contact_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Model/add_contact_model.dart';
import '../../util.dart';

class add_contact_ios extends StatefulWidget {
  add_contact_ios({super.key});

  @override
  State<add_contact_ios> createState() => _add_contact_iosState();
}

class _add_contact_iosState extends State<add_contact_ios> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Consumer<ContactProvider>(
            builder: (context, contactProvider, child) {
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      contactProvider.imagecamera();
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: contactProvider.xFile != null
                          ? FileImage(
                              File(contactProvider.xFile?.path ?? ""),
                            )
                          : null,
                      child: contactProvider.xFile == null
                          ? const Icon(
                              CupertinoIcons.photo_camera,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Transform.scale(
                    scale: 1.10,
                    child: CupertinoTextFormFieldRow(
                      controller: contactProvider.nameController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter Full Name";
                        } else {
                          return null;
                        }
                      },
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      placeholder: "Full Name",
                      prefix: const Icon(
                        CupertinoIcons.person,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Transform.scale(
                    scale: 1.10,
                    child: CupertinoTextFormFieldRow(
                      controller: contactProvider.phoneController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter Phone Number";
                        } else if (val.length != 10) {
                          return "Not Valid Number";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      placeholder: "Phone Number",
                      prefix: const Icon(
                        CupertinoIcons.phone,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Transform.scale(
                    scale: 1.10,
                    child: CupertinoTextFormFieldRow(
                      controller: contactProvider.chatController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return " Please Enter Any Message";
                        } else {
                          return null;
                        }
                      },
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      placeholder: "Chat Conversation",
                      prefix: const Icon(
                        CupertinoIcons.chat_bubble_text,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CupertinoButton(
                          child: Icon(CupertinoIcons.calendar),
                          onPressed: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) => Container(
                                      color: Colors.white,
                                      height: 300,
                                      child: CupertinoDatePicker(
                                        onDateTimeChanged: (value) {
                                          contactProvider.selectdate = value;
                                          contactProvider.refresh();
                                          print(
                                              "${contactProvider.selectdate!.day}-${contactProvider.selectdate!.month}-${contactProvider.selectdate!.year}");
                                        },
                                        mode: CupertinoDatePickerMode.date,
                                      ),
                                    ));
                          }),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        contactProvider.selectdate != null
                            ? contactProvider.mydate
                                .format(contactProvider.selectdate!)
                            : "Pick Date",
                        style: TextStyle(fontSize: 15, color: Colors.black54),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CupertinoButton(
                          child: Icon(CupertinoIcons.time),
                          onPressed: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) => Container(
                                      color: Colors.white,
                                      height: 300,
                                      child: CupertinoDatePicker(
                                        onDateTimeChanged: (value) {
                                          contactProvider.selecttime =
                                              TimeOfDay.fromDateTime(value);
                                          contactProvider.refresh();
                                          print(
                                              "${contactProvider.selecttime?.hour}-${contactProvider.selecttime?.minute}");
                                        },
                                        mode: CupertinoDatePickerMode.time,
                                      ),
                                    ));
                          }),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        contactProvider.selecttime != null
                            ? "${contactProvider.selecttime?.hour}:${contactProvider.selecttime?.minute}"
                            : "Pick Time",
                        style: TextStyle(fontSize: 15, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CupertinoButton(
                    onPressed: () {
                      var cp =
                          Provider.of<ContactProvider>(context, listen: false);

                      ContactModal cm = ContactModal(
                          name: cp.nameController.text,
                          number: cp.phoneController.text,
                          chat: cp.chatController.text,
                          selectdate: cp.selectdate,
                          selecttime: cp.selecttime,
                          xFile: cp.xFile);
                      if (formKey.currentState?.validate() ?? false) {
                        if (cp.selectdate == null) {
                          PickDateDialog(context);
                        } else if (cp.selecttime == null) {
                          PickTimeDialog(context);
                        } else {
                          contactProvider.addcontact(cm);
                          saveContactList();
                          loadContactList();
                          contactProvider.reset();
                          Provider.of<ContactProvider>(context, listen: false)
                              .refresh();
                          showSaveContactDialog(context);
                          print(contactList.length);
                        }
                      }
                    },
                    child: const Text("Save"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void showSaveContactDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Contact Saved'),
          content: Text('The contact has been successfully saved.'),
          actions: [
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void PickDateDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Pick Date'),
          content: Text('The Date was not selected !!'),
          actions: [
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void PickTimeDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Pick Time'),
          content: Text('The Date was not selected !!'),
          actions: [
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
