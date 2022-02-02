import 'package:mental/shared/tools.dart';

class Chantier {
  // field
  int? id;
  String name;
  String adresse;
  String designation;
  String description;
  String materiaux;
  String travaux;
  String? client;

  Chantier(this.id, this.name, this.adresse, this.designation, this.description,
      this.materiaux, this.travaux, this.client);

  @override
  String toString() {
    return 'Chantier{id: $id, name: $name, adresse: $adresse, designation: $designation, description: $description, materiaux: $materiaux, travaux: $travaux, client: $client}';
  }

  bool isValid() {
    return !Tools.isNullEmpty(this.name) &&
        !Tools.isNullEmpty(this.adresse) &&
        !Tools.isNullEmpty(this.designation) &&
        !Tools.isNullEmpty(this.description) &&
        !Tools.isNullEmpty(this.materiaux) &&
        !Tools.isNullEmpty(this.travaux) &&
        !Tools.isNullEmpty(this.client!);
  }
}
