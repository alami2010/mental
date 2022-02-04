class Data {
  // field
  int? id;
  String name;
  int progress;

  Data(
    this.id,
    this.name,
    this.progress,
  );

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(json['id'], json['name'],
        json['progress'] == null ? 0 : json['progress']);
  }

  @override
  String toString() {
    return 'Data{id: $id, name: $name, progress: $progress}';
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'progress': progress};
}
