class Photo {
  // field
  String url;
  String name;

  Photo(
    this.url,
    this.name,
   );

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(json['url'], json['name']);
  }
}
