class Data {
  // field
  int? id;
  String name;

  Data(
    this.id,
    this.name,
   );

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(json['id'], json['name']);
  }
}
