import 'dart:async';
import 'dart:io' as io;

import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mental/model/chantier.dart';
import 'package:path/path.dart';

const baseUrl = "https://alamio.fr/3h_metal/public/api/";
//const baseUrl = "http://127.0.0.1:8000/api/";

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
        "designation": chantier.designation,
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
    print("hello");
    //---Create http package multipart request object
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("https://alamio.fr/3h_metal/public/api/nv-chantier"),
    );
    //-----add other fields if needed
    request.fields["name"] =chantier.name;
    request.fields["adresse"] =chantier.adresse;
    request.fields["designation"] =chantier.designation;
    request.fields["description"] =chantier.description;
    request.fields["travaux"] =chantier.travaux;
    request.fields["materiaux"] =chantier.materiaux;
    request.fields["client"] =chantier.client!;


    if (!files.isEmpty) {
      files.forEach((element) async {
        var pic = await http.MultipartFile.fromPath(
            basename(element.path), element.path);
        //add multipart to request
        request.files.add(pic);
      });
    }

    //-------Send request
    var resp = await request.send();

    //------Read response
    String result = await resp.stream.bytesToString();

    //-------Your response
    print(result);
    print("upload finish");
  }


  static Future chantiers() {
    var url = baseUrl + "chantier";
    showUrl(url);
    return http.get(Uri.parse(url));
  }
}
