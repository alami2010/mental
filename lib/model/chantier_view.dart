import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mental/model/data.dart';
import 'package:mental/model/horaire.dart';
import 'package:mental/model/plan.dart';

class ChantierView {
  // field
  int id;
  String name;
  String adresse;
  String description;
  String status;
  String supp;
  String materiaux;
  String client;
  List<Data> listTravaux;
  List<String> listMateriaux;
  List<Plan> listPlans;
  List<Horaire> horaires;

  ChantierView(
      this.id,
      this.name,
      this.adresse,
      this.description,
      this.status,
      this.supp,
      this.materiaux,
      this.client,
      this.listTravaux,
      this.listMateriaux,
      this.listPlans,
      this.horaires);

  factory ChantierView.fromJson(Map<String, dynamic> json) {
    return ChantierView(
        json['id'],
        json['name'],
        json['adresse'],
        json['description'],
        json['status'],
        json['supp'] == null ? "" : json['supp'],
        json['materiaux'],
        json['client'],
        List<Data>.from(json["listTravaux"].map((x) => Data.fromJson(x))),
        json['listMateriaux'].cast<String>(),
        List<Plan>.from(json["listPlans"].map((x) => Plan.fromJson(x))),
        List<Horaire>.from(json["horaires"].map((x) => Horaire.fromJson(x))));
  }

  Color getStatusColor() {
    if (status == 'NEW') return Color(0xffFEA741);
    if (status == 'START') return Color(0xff31DFB5);
    return Color(0xffB5C8E7);
  }

  String getStatusName() {
    if (status == 'NEW') return "Nouveau";
    if (status == 'START') return "En cours";
    return "Archivé";
  }

  Icon getStatusIcon() {
    if (status == 'NEW') return Icon(EvaIcons.award);
    if (status == 'START') return Icon(EvaIcons.activityOutline);
    return Icon(EvaIcons.lock);
  }
}
