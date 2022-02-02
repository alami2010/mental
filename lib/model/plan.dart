class Plan {
  // field
  String url;
  String name;

  Plan(
    this.url,
    this.name,
   );

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(json['url'], json['name']);
  }
}
