import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/contacts/contact.dart';

class FirestoreService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getContacts(String category) {
    return db
        .collection('contacts')
        .doc('G7zz3UnSiNJpqUpWJyF1')
        .collection(category)
        .snapshots();
  }

  Future createContact(
      {name,
      category,
      strasse,
      firma,
      lieferantenNr,
      kundenNr,
      plz,
      ort,
      mobil,
      email,
      telefon}) async {
    final docContact = db
        .collection('contacts')
        .doc('G7zz3UnSiNJpqUpWJyF1')
        .collection(category)
        .doc();
    final contact = Contact(
        id: docContact.id,
        name: name,
        strasse: strasse,
        firma: firma,
        lieferantenNr: lieferantenNr,
        kundenNr: kundenNr,
        plz: plz,
        ort: ort,
        mobil: mobil,
        email: email,
        telefon: telefon);
    final json = contact.toJson();
    await docContact.set(json);
  }

  void updateContact(
      {id,
      name,
      category,
      strasse,
      firma,
      lieferantenNr,
      kundenNr,
      plz,
      ort,
      mobil,
      email,
      telefon}) async {
    final docContact = db
        .collection('contacts')
        .doc('G7zz3UnSiNJpqUpWJyF1')
        .collection(category)
        .doc(id);
    docContact.update({
      'name': name,
      'strasse': strasse,
      'firma': firma,
      'lieferantenNr': lieferantenNr,
      'kundenNr': kundenNr,
      'plz': plz,
      'ort': ort,
      'telefon': telefon,
      'mobil': mobil,
      'email': email,
    });
  }

  void deleteContact({id, category}) {
    final docContact = db
        .collection('contacts')
        .doc('G7zz3UnSiNJpqUpWJyF1')
        .collection(category)
        .doc(id);
    docContact.delete();
  }
}
