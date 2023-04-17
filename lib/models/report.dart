// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final DateTime date;
  final int hours;
  final int minutes;
  Report({
    required this.date,
    required this.hours,
    required this.minutes,
  });

  Report copyWith({
    DateTime? date,
    int? hours,
    int? minutes,
  }) {
    return Report(
      date: date ?? this.date,
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'hours': hours,
      'minutes': minutes,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      hours: map['hours'] as int,
      minutes: map['minutes'] as int,
    );
  }

  factory Report.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return Report(
        date: data['date'].toDate(),
        hours: data['hours'],
        minutes: data['minutes']);
  }

  Map<String, Object?> toFirestore() {
    return {"date": Timestamp.fromDate(date), "hours": hours};
  }

  String toJson() => json.encode(toMap());

  factory Report.fromJson(String source) =>
      Report.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Report(date: $date, hours: $hours, minutes: $minutes)';

  @override
  bool operator ==(covariant Report other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.hours == hours &&
        other.minutes == minutes;
  }

  @override
  int get hashCode => date.hashCode ^ hours.hashCode ^ minutes.hashCode;
}
