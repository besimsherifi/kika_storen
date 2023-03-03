import 'package:cloud_firestore/cloud_firestore.dart';

class Termin {
  final String id;
  final String name;
  final String address;
  final DateTime date;
  final String time;
  final String notes;

  Termin(
      {required this.id,
      required this.name,
      required this.address,
      required this.date,
      required this.time,
      required this.notes});

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'name': name,
  //       'address': address,
  //       'date': date,
  //       'time': time,
  //       'notes': notes,
  //     };

  // static Termin fromJson(Map<String, dynamic> json) => Termin(
  //       id: json['id'],
  //       name: json['name'],
  //       address: json['address'],
  //       date: json['date'],
  //       time: json['time'],
  //       notes: json['notes'],
  //     );
  factory Termin.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return Termin(
      date: data['date'].toDate(),
      name: data['name'],
      notes: data['notes'],
      id: snapshot.id,
      time: data['time'],
      address: data['address'],
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      "date": Timestamp.fromDate(date),
      'id': id,
      'name': name,
      'address': address,
      'time': time,
      'notes': notes,
    };
  }
}
