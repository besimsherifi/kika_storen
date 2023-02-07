class Termin {
  final String id;
  final String name;
  final String address;
  final String date;
  final String time;
  final String notes;

  Termin(
      {this.id = '',
      this.name = '',
      this.address = '',
      this.date = '',
      this.time = '',
      this.notes = ''});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'date': date,
        'time': time,
        'notes': notes,
      };

  static Termin fromJson(Map<String, dynamic> json) => Termin(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        date: json['date'],
        time: json['time'],
        notes: json['notes'],
      );
}
