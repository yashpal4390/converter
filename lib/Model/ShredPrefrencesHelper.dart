import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_contact_model.dart';

class SharedPreferencesHelper {
  static const String key = 'contactList';

  static Future<void> saveContactList(List<ContactModal> contactList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> serializedList = contactList.map((contact) => contact.toJson()).toList();
    String jsonString = json.encode(serializedList);
    prefs.setString(key, jsonString);
  }

  static Future<List<ContactModal>> getContactList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedJsonString = prefs.getString(key);

    if (storedJsonString != null) {
      List<Map<String, dynamic>> storedList = List<Map<String, dynamic>>.from(json.decode(storedJsonString));
      List<ContactModal> retrievedList = storedList.map((json) => ContactModal.fromJson(json)).toList();
      return retrievedList;
    } else {
      return [];
    }
  }
}
