class Data {
  // field
  int id;
  String name;
  int progress;
  int qte;

  Data(
    this.id,
    this.name,
    this.progress,
    this.qte,
  );

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        json['id'],
        json['name'],
        json['progress'] == null ? 0 : json['progress'],
        json['qte'] == null ? 0 : json['qte']);
  }

  @override
  String toString() {
    return 'Data{id: $id, name: $name, progress: $progress, qte: $qte}';
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'progress': progress, 'qte': qte};
}
