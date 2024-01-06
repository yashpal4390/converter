import 'Model/ShredPrefrencesHelper.dart';
import 'Model/add_contact_model.dart';

List<ContactModal> contactList = [];
List<ContactModal> loadedList = [];

Future<void> loadContactList() async {
  List<ContactModal> loadedList =
      await SharedPreferencesHelper.getContactList();
  contactList = loadedList;
}

Future<void> saveContactList() async {
  await SharedPreferencesHelper.saveContactList(contactList);
}

Future<void> deleteContactList(int index) async {
  await SharedPreferencesHelper.deleteContact(index);
  contactList.removeAt(index);
  loadContactList();
}
