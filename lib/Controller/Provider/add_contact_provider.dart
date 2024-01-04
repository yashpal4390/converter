import 'package:converter/Model/add_contact_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../View/Android/add_contact_android.dart';


class ContactProvider extends ChangeNotifier {
  XFile? xFile;
  ImagePicker picker = ImagePicker();
  XFile? settingxFile;
  final mydate = DateFormat.yMd();
  final mydatetime = DateFormat.yMMMEd();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController chatController = TextEditingController();

  TextEditingController settingnameController = TextEditingController();
  TextEditingController settingbioController = TextEditingController();

  DateTime? selectdate;
  TimeOfDay? selecttime;

  void addcontact(ContactModal contact) {
    // contactlist.add(contact);
    // ContactList contactList = ContactList(contactList: [
    //     ContactListElement(
    //     name: nameController.text,
    //     number: phoneController.text,
    //     chat: chatController.text,
    //     selectdate: selectdate.toString(),
    //     selecttime: selecttime.toString(),
    //     xFile: xFile.toString(),
    // ),
    // ]);
    //
    // var rawJson = contactList.toRawJson();
    // prefs.setString("model", rawJson);
    contactList.add(
      ContactModal(
          name: nameController.text,
          number: phoneController.text,
          chat: chatController.text,
          selectdate: selectdate,
          selecttime: selecttime,
          xFile: xFile,
      ),
    );
    notifyListeners();
  }

  void imagecamera() {
    picker.pickImage(source: ImageSource.camera).then(
      (value) {
        xFile = value;
        notifyListeners();
      },
    );
  }

  void reset() {
    nameController.clear();
    phoneController.clear();
    chatController.clear();
    selectdate = null;
    selecttime = null;
    xFile = null;
    notifyListeners();
  }

  void editContact(int index, ContactModal contact) {
    // contactlist[index] = contact;
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }

  void deleteContact(int index) {
    // contactlist.removeAt(index);
    notifyListeners();
  }
}
