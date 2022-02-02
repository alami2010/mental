import 'package:mental/model/plan.dart';

class ChantierView {
  // field
  int? id;
  String name;
  String adresse;
  String designation;
  String description;
  String status;
  String materiaux;
  String travaux;
  String client;
  List<String> listTravaux;
  List<String> listMateriaux;
  List<Plan> listPlans;

  ChantierView(
      this.id,
      this.name,
      this.adresse,
      this.designation,
      this.description,
      this.status,
      this.materiaux,
      this.travaux,
      this.client,
      this.listTravaux,
      this.listMateriaux,
      this.listPlans);

  factory ChantierView.fromJson(Map<String, dynamic> json) {
    return ChantierView(
        json['id'],
        json['name'],
        json['adresse'],
        json['designation'],
        json['description'],
        json['status'],
        json['materiaux'],
        json['travaux'],
        json['client'],
        json['listTravaux'].cast<String>(),
        json['listMateriaux'].cast<String>(),
        List<Plan>.from(json["listPlans"].map((x) => Plan.fromJson(x))));
  }
}
