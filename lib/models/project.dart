// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Project {
  final String id;
  final String name;
  final String customer;
  final String address;
  final String category;
  final DateTime startDate;
  final DateTime endDate;
  final List blinds;
  final String notes;
  Project({
    required this.id,
    required this.name,
    required this.customer,
    required this.address,
    required this.category,
    required this.startDate,
    required this.endDate,
    required this.blinds,
    required this.notes,
  });

  factory Project.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return Project(
        id: snapshot.id,
        name: data['name'],
        customer: data['customer'],
        category: data['category'],
        startDate: data['startDate'].toDate(),
        endDate: data['endDate'].toDate(),
        notes: data['notes'],
        address: data['address'],
        blinds: data['blinds']);
  }

  Map<String, Object?> toFirestore() {
    return {
      "startDate": Timestamp.fromDate(startDate),
      "endDate": Timestamp.fromDate(endDate),
      'id': id,
      'name': name,
      'customer': customer,
      'category': category,
      'address': address,
      'notes': notes,
      'blinds': blinds
    };
  }

  Project copyWith({
    String? id,
    String? name,
    String? customer,
    String? address,
    String? category,
    DateTime? startDate,
    DateTime? endDate,
    List? blinds,
    String? notes,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      customer: customer ?? this.customer,
      address: address ?? this.address,
      category: category ?? this.category,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      blinds: blinds ?? this.blinds,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'blinds': blinds,
      'notes': notes,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'] as String,
      name: map['name'] as String,
      customer: map['customer'] as String,
      address: map['address'] as String,
      category: map['category'] as String,
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate'] as int),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate'] as int),
      blinds: List.from(
        (map['blinds'] as List),
      ),
      notes: map['notes'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) =>
      Project.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Project(id: $id, name: $name, address: $address, startDate: $startDate, endDate: $endDate, blinds: $blinds, notes: $notes)';
  }

  @override
  bool operator ==(covariant Project other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.address == address &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        listEquals(other.blinds, blinds) &&
        other.notes == notes;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        address.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        blinds.hashCode ^
        notes.hashCode;
  }
}
