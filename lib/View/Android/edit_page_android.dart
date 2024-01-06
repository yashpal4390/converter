// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controller/Provider/add_contact_provider.dart';
import '../../Model/add_contact_model.dart';
import '../../util.dart';

class edit_page_android extends StatefulWidget {
  final int? ind;

  edit_page_android({super.key, this.ind});

  @override
  State<edit_page_android> createState() => _edit_page_androidState();
}

GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _edit_page_androidState extends State<edit_page_android> {
  void initState() {
    if (widget.ind != null) {
      var cp = Provider.of<ContactProvider>(context, listen: false);
      cp.nameController.text = contactList[widget.ind!].name!;
      cp.phoneController.text = contactList[widget.ind!].number!;
      cp.chatController.text = contactList[widget.ind!].chat!;
      cp.xFile = contactList[widget.ind!].xFile;
      cp.selecttime = contactList[widget.ind!].selecttime;
      cp.selectdate = contactList[widget.ind!].selectdate;
    }
    super.initState();
    loadContactList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Platform Converter"),
        centerTitle: true,
        leading: SizedBox(),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Consumer<ContactProvider>(
                builder: (context, contactProvider, child) {
              return Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: 3, bottom: 8, right: 8, left: 8),
                    child: InkWell(
                      onTap: () {
                        contactProvider.imagecamera();
                      },
                      child: CircleAvatar(
                        minRadius: MediaQuery.sizeOf(context).height * 0.09,
                        backgroundImage: contactProvider.xFile != null
                            ? FileImage(
                                File(contactProvider.xFile?.path ?? ""),
                              )
                            : null,
                        child: contactProvider.xFile == null
                            ? Icon(Icons.add_a_photo_outlined)
                            : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 6, left: 2, right: 2, bottom: 6),
                    child: TextFormField(
                      controller: contactProvider.nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "Full Name",
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter Full Name";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 6, left: 2, right: 2, bottom: 6),
                    child: TextFormField(
                      controller: contactProvider.phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        hintText: "Phone Number",
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Phone Number";
                        } else if (val.length != 10) {
                          return "Not Valid Number";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 6, left: 2, right: 2, bottom: 6),
                    child: TextFormField(
                      controller: contactProvider.chatController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.chat),
                        hintText: "Chat Conversation",
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter Chat Conversion";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 8),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            contactProvider.selectdate = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2050),
                              initialDate: DateTime.now(),
                            );
                            contactProvider.refresh();
                          },
                          child: Icon(
                            Icons.calendar_month,
                            size: 20,
                          ),
                        ),
                        SizedBox(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 8),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            contactProvider.selecttime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            contactProvider.refresh();
                          },
                          child: Icon(
                            Icons.access_time_outlined,
                            size: 20,
                          ),
                        ),
                        SizedBox(
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
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        var cp = Provider.of<ContactProvider>(context,
                            listen: false);

                        ContactModal cm = ContactModal(
                            name: cp.nameController.text,
                            number: cp.phoneController.text,
                            chat: cp.chatController.text,
                            selectdate: cp.selectdate,
                            selecttime: cp.selecttime,
                            xFile: cp.xFile);

                        if (formKey.currentState?.validate() ?? false) {
                          if (cp.selectdate == null) {
                            final snackBar = SnackBar(
                              content: Text('Pick Date Please !!'),
                              duration: Duration(
                                  seconds: 2), // You can customize the duration
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (cp.selecttime == null) {
                            final snackBar = SnackBar(
                              content: Text('Pick Time Please !!'),
                              duration: Duration(
                                  seconds: 2), // You can customize the duration
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (widget.ind != null) {
                            contactList[widget.ind!] = cm;
                            saveContactList();
                            loadContactList();
                            contactProvider.reset();
                            final snackBar = SnackBar(
                              content: Text('Contact Edited Successfully'),
                              backgroundColor: Colors.blueGrey,
                              duration: Duration(
                                  seconds: 2), // You can customize the duration
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        } else {
                          print("something wrong");
                        }
                      },
                      child: Text('SAVE'),
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
