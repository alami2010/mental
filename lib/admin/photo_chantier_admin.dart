import 'dart:convert';
import 'dart:io' as io;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mental/model/chantier_view.dart';
import 'package:mental/model/photo.dart';
import 'package:mental/shared/api_rest.dart';

class PhotoChantierAdmin extends StatefulWidget {
  final ChantierView chantier;

  const PhotoChantierAdmin({required this.chantier}) : super();

  @override
  State<PhotoChantierAdmin> createState() => _PhotoChantierAdminState();
}

class _PhotoChantierAdminState extends State<PhotoChantierAdmin> {
  TextEditingController nameController = TextEditingController();

  List<Photo> photos = <Photo>[];

  @override
  void initState() {
    super.initState();
    getPhotosChantier(widget.chantier.id);
  }

  getPhotosChantier(int id) {
    APIRest.getPhotos(id).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        photos = list.map((model) => Photo.fromJson(model)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo de chantier ' + widget.chantier.name),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext ctx, int index) {
          print('http://127.0.0.1:8000/files/'+photos[index].url);
          return Image.network('http://127.0.0.1:8000/files/'+photos[index].url);
        },
        itemCount: photos.length,
      ),
    );
  }

// set up the AlertDialog
}
