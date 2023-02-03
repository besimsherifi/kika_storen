class Contact {
  final String id;
  final String name;
  final String strasse;
  final String firma;
  final String lieferantenNr;
  final String kundenNr;
  final String plz;
  final String ort;
  final String mobil;
  final String email;
  final String telefon;

  Contact({
    this.name = '',
    this.strasse = '',
    this.id = '',
    this.firma = '',
    this.lieferantenNr = '',
    this.kundenNr = '',
    this.plz = '',
    this.ort = '',
    this.mobil = '',
    this.email = '',
    this.telefon = '',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'strasse': strasse,
        'firma': firma,
        'lieferantenNr': lieferantenNr,
        'kundenNr': kundenNr,
        'plz': plz,
        'ort': ort,
        'mobil': mobil,
        'email': email,
        'telefon': telefon,
      };

  static Contact fromJson(Map<String, dynamic> json) => Contact(
        id: json['id'],
        name: json['name'],
        strasse: json['strasse'],
        firma: json['firma'],
        lieferantenNr: json['lieferantenNr'],
        kundenNr: json['kundenNr'],
        plz: json['plz'],
        ort: json['ort'],
        mobil: json['mobil'],
        email: json['email'],
        telefon: json['telefon'],
      );
}
