import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/contacts/contact.dart';

class FirestoreService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getContacts(String contactType) {
    return db
        .collection('contacts')
        .doc('G7zz3UnSiNJpqUpWJyF1')
        .collection(contactType)
        .snapshots();
  }

  void addContact(name, category) async {
    Contact contact = Contact(name);
    await db
        .collection('contacts')
        .doc('G7zz3UnSiNJpqUpWJyF1')
        .collection(category)
        .add(contact.toJson());
  }
}

//TODO id e kontanteve duhet tekstraktohet