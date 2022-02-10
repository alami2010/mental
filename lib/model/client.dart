class Client {
  // field
  int id;
  String name;
  bool professional;

  Client(
    this.id,
    this.name,
    this.professional,
  );

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(json['id'], json['name'], json['professional'] == 1);
  }
}
