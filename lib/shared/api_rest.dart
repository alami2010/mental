import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mental/constants/constants.dart';
import 'package:mental/model/chantier.dart';
import 'package:mental/model/data.dart';
import 'package:mental/model/horaire.dart';
import 'package:path/path.dart';

const baseUrl = baseUrlMental + "api/";
//const baseUrl = baseUrlMental + "/api/";

class APIRest {
  static Future getClients() {
    var url = baseUrl + "client";
    return http.get(Uri.parse(url));
  }

  static Future deleteClient(int id) {
    var url = baseUrl + "client/" + id.toString();
    return http.delete(Uri.parse(url));
  }

  static Future createClient(String text, bool isProfessional) {
    int professional = isProfessional ? 1 : 0;
    var url = baseUrl +
        "client?name=" +
        text +
        "&professional=" +
        professional.toString();
    return http.post(Uri.parse(url));
  }

  static Future getMateriaux() {
    var url = baseUrl + "material";
    showUrl(url);
    return http.get(Uri.parse(url));
  }

  static Future deletMateriaux(int id) {
    var url = baseUrl + "material/" + id.toString();
    showUrl(url);
    return http.delete(Uri.parse(url));
  }

  static Future createMateriaux(String text) {
    var url = baseUrl + "material?name=" + text;
    showUrl(url);
    return http.post(Uri.parse(url));
  }

  static Future getTravaux() {
    var url = baseUrl + "travail";
    showUrl(url);
    return http.get(Uri.parse(url));
  }

  static Future deletTravail(int id) {
    var url = baseUrl + "travail/" + id.toString();
    showUrl(url);
    return http.delete(Uri.parse(url));
  }

  static Future createTravail(String text) {
    var url = baseUrl + "travail?name=" + text;
    showUrl(url);
    return http.post(Uri.parse(url));
  }

  static void showUrl(String url) {
    print(url);
  }

  static Future uploadFileWeb(
      List<PlatformFile> platformFiles, Chantier chantier) async {
    try {
      var formData = dio.FormData.fromMap({
        "name": chantier.name,
        "adresse": chantier.adresse,
        "description": chantier.description,
        "travaux": chantier.travaux,
        "materiaux": chantier.materiaux,
        "client": chantier.client,
      });
      if (!platformFiles.isEmpty) {
        platformFiles.forEach((element) {
          var mfile = dio.MultipartFile.fromBytes(element.bytes!,
              filename: element.name);
          formData.files.add(MapEntry(element.name, mfile));
        });
      }

      await await dio.Dio().post(baseUrl + 'nv-chantier', data: formData);
    } on dio.DioError catch (error) {
      throw Exception(error);
    }
  }

  static Future uploadFileMobile(List<io.File> files, Chantier chantier) async {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse(baseUrl + 'nv-chantier'),
    );
    request.fields["name"] = chantier.name;
    request.fields["adresse"] = chantier.adresse;
    request.fields["description"] = chantier.description;
    request.fields["travaux"] = chantier.travaux;
    request.fields["materiaux"] = chantier.materiaux;
    request.fields["client"] = chantier.client!;

    if (!files.isEmpty) {
      files.forEach((element) async {
        var pic = await http.MultipartFile.fromPath(
            basename(element.path), element.path);
        request.files.add(pic);
      });
    }

    var resp = await request.send();
    String result = await resp.stream.bytesToString();
    print("upload finish");
  }

  static Future chantiersNewAndStartStatus() {
    var url = baseUrl + "chantier";
    showUrl(url);
    return http.get(Uri.parse(url));
  }

  static Future chantiersStartStatus() {
    var url = baseUrl + "chantier-start";
    showUrl(url);
    return http.get(Uri.parse(url));
  }

  static Future chantiersDoneStatus() {
    var url = baseUrl + "chantier-done";
    showUrl(url);
    return http.get(Uri.parse(url));
  }

  static Future changeChantierStatus(int id, String status) {
    return http.post(
      Uri.parse(baseUrl + 'change-chantier-status'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id.toString(),
        'status': status,
      }),
    );
  }

  static Future saveProgress(List<Data> listTravaux, int id) {
    List jsonList = [];
    listTravaux.map((item) => jsonList.add(item.toJson())).toList();
    return http.post(Uri.parse(baseUrl + 'change-chantier-process'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': id.toString(),
          'travaux': jsonEncode(jsonList),
        }));
  }

  static saveTravauxSupp(String supp, int id) {
    return http.post(
      Uri.parse(baseUrl + 'change-chantier-supp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id.toString(),
        'supp': supp,
      }),
    );
  }

  static Future getAllMateriauxManquant() {
    var url = baseUrl + "materiaux-manquant";
    showUrl(url);
    return http.get(Uri.parse(url));
  }

  static Future createMateriauxManquant(String text) {
    var url = baseUrl + "materiaux-manquant?name=" + text;
    showUrl(url);
    return http.post(Uri.parse(url));
  }

  static Future saveQte(int id, int qte) {
    return http.post(
      Uri.parse(baseUrl + 'materiaux-manquant-qte'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id.toString(),
        'qte': qte.toString(),
      }),
    );
  }

  static Future getMateriauxManquant() {
    var url = baseUrl + "materiaux-manquant-qte";
    showUrl(url);
    return http.get(Uri.parse(url));
  }

  static Future saveHoraire(Horaire horaire, int id) {
    return http.post(
      Uri.parse(baseUrl + 'horaire'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id.toString(),
        'debutMatin': horaire.debutMatin,
        'debutSoir': horaire.debutSoir,
        'finMatin': horaire.finMatin,
        'finSoir': horaire.finSoir,
        'date': horaire.date,
        'weekday': horaire.weekday.toString(),
      }),
    );
  }

  static Future getPhotos(int id) {
    var url = baseUrl + "photo-chantier?id=" + id.toString();
    showUrl(url);
    return http.get(Uri.parse(url));
  }

  static Future uploadPhotoWeb(
      List<PlatformFile> platformFiles, int idChantier) async {
    try {
      var formData = dio.FormData.fromMap({"id": idChantier});
      if (!platformFiles.isEmpty) {
        platformFiles.forEach((element) {
          var mfile = dio.MultipartFile.fromBytes(element.bytes!,
              filename: element.name);
          formData.files.add(MapEntry(element.name, mfile));
        });
      }

      return await await dio.Dio()
          .post(baseUrl + 'photo-chantier-upload', data: formData);
    } on dio.DioError catch (error) {
      throw Exception(error);
    }
  }

  static Future uploadPhotoMobile(List<io.File> files, int idChantier) async {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse(baseUrl + 'photo-chantier-upload'),
    );
    request.fields["id"] = idChantier.toString();
    if (!files.isEmpty) {
      files.forEach((element) async {
        var pic = await http.MultipartFile.fromPath(
            basename(element.path), element.path);
        request.files.add(pic);
      });
    }
    var resp = await request.send();
    return await resp.stream.bytesToString();
  }
}
