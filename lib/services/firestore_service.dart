import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kika_storen/models/termin.dart';

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

  void createAppointment(name, address, date, time, notes) async {
    final docAppointment = db.collection('appointments').doc();
    // final appointment = Termin(
    //     id: docAppointment.id,
    //     name: name,
    //     address: address,
    //     date: date,
    //     time: time,
    //     notes: notes);
    // final json = appointment.toFirestore();
    // await docAppointment.set(json);
    await FirebaseFirestore.instance.collection('appointments').add({
      "name": name,
      "address": address,
      "notes": notes,
      "time": time,
      "date": Timestamp.fromDate(date),
    });
  }

  void updateAppointment({id, name, address, date, time, notes}) async {
    await db.collection('appointments').doc(id).update({
      "name": name,
      "address": address,
      "date": Timestamp.fromDate(date),
      "time": time,
      "notes": notes
    });
  }

  getAppointments() {
    db
        .collection('appointments')
        .withConverter(
          fromFirestore: Termin.fromFirestore,
          toFirestore: (Termin termin, options) => termin.toFirestore(),
        )
        .snapshots();
  }

  // Stream<QuerySnapshot<Map<String, dynamic>>> getAppointments2(date) {
  //   return db
  //       .collection('appointments')
  //       .where('date', isEqualTo: Timestamp.fromDate(date))
  //       .snapshots();
  // }
}
