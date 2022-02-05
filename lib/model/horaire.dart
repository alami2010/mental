class Horaire {
  // field
  int? id;
  String date;
  String debutMatin;
  String debutSoir;
  String finMatin;
  String finSoir;
  int weekday;

  Horaire(
    this.id,
    this.date,
    this.debutMatin,
    this.debutSoir,
    this.finMatin,
    this.finSoir,
    this.weekday,
  );

  factory Horaire.fromJson(Map<String, dynamic> json) {
    return Horaire(json['id'], json['date'], json['debutMatin'],
        json['debutSoir'], json['finMatin'], json['finSoir'], json['weekday']);
  }

  @override
  String toString() {
    return 'Horaire{id: $id, date: $date, debutMatin: $debutMatin, debutSoir: $debutSoir, finMatin: $finMatin, finSoir: $finSoir, weekday: $weekday}';
  }
}
