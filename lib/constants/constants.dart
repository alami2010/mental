import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';

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
