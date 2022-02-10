import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mental/admin/chantier_done.dart';
import 'package:mental/admin/chantier_new_start.dart';
import 'package:mental/admin/chantier_nouveau.dart';
import 'package:mental/admin/list_client.dart';
import 'package:mental/admin/list_materiaux.dart';
import 'package:mental/admin/list_travaux.dart';
import 'package:mental/admin/materiaux_manquant.dart';
import 'package:mental/components/list_task_assigned.dart';

class Font {
  static const nunito = 'Nunito';
}

class ImageAnimationPath {
  // you can get free animation image from rive or lottiefiles

  // Example:
  // static const _folderPath = "assets/images/animation";
  // static const myAnim = "$_folderPath/my_anim.json";
}

class ImageRasterPath {
  static const _folderPath = "assets/images/raster";
  static const logo = "$_folderPath/logo.png";
// static const myRaster2 = "$_folderPath/my_raster2.jpg";
// static const myRaster3 = "$_folderPath/my_raster3.jpeg";
}

class ImageVectorPath {
  // Example:
  // static const _folderPath = "assets/images/vector";
  // static const myVector = "$_folderPath/vector/my_vector.svg";
}

var secondaryColor = Color(0xFF5593f8);
var primaryColor = Color(0xFF48c9e2);

const kFontColorPallets = [
  Color.fromRGBO(26, 31, 56, 1),
  Color.fromRGBO(72, 76, 99, 1),
  Color.fromRGBO(149, 149, 163, 1),
];
const kBorderRadius = 10.0;
const kSpacing = 20.0;

const kLightTextColor = Color(0xffB5C8E7);
const kHardTextColor = Color(0xff586191);

const kPrimaryDarkColor = Color(0xff46BDFA);
const kPrimarylightColor = Color(0xff77E2FE);
const kBackgroundColor = Color(0xffEFF2F7);

const List<Color> kCategoriesPrimaryColor = [
  Color(0xffFFCA8C),
  Color(0xff5DF9D3),
  Color(0xff85E4FD),
  Color(0xffB8ACFF)
];

const List<Color> kCategoriesSecondryColor = [
  Color(0xffFEA741),
  Color(0xff31DFB5),
  Color(0xff45BAFB),
  Color(0xff9182F9)
];

const baseUrlMental = "https://alamio.fr/3h_metal/public/";
//
//const baseUrlMental = "http://127.0.0.1:8000/";

List<ListMenuData> initListMenu() {
  return [
    const ListMenuData(
        color: Colors.blue,
        icon: Icon(EvaIcons.home, color: Colors.white),
        label: "Liste Travaux",
        page: ListTravaux()),
    const ListMenuData(
      color: Colors.amber,
      icon: Icon(EvaIcons.homeOutline, color: Colors.white),
      label: "Liste matériaux",
      page: ListMateriaux(),
    ),
    const ListMenuData(
      color: Colors.orange,
      icon: Icon(EvaIcons.people, color: Colors.white),
      label: "Liste clients",
      page: ListClient(),
    ),
    const ListMenuData(
      color: Colors.teal,
      icon: Icon(EvaIcons.plusCircle, color: Colors.white),
      label: "Nouveau chantier",
      page: NouveauChantier(),
    ),
    const ListMenuData(
      color: Colors.purple,
      icon: Icon(EvaIcons.pieChart, color: Colors.white),
      label: "Chantier en cours",
      page: ChantierNewStart(),
    ),
    const ListMenuData(
      color: Colors.green,
      icon: Icon(EvaIcons.alertCircle, color: Colors.white),
      label: "Matérieux manquants",
      page: MateriauxManquant(),
    ),
    const ListMenuData(
      color: Color(0xffB5C8E7),
      icon: Icon(EvaIcons.archive, color: Colors.white),
      label: "Chantiers archivés",
      page: ChantierDone(),
    ),
  ];
}
