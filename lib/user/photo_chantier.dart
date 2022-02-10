import 'dart:convert';
import 'dart:io' as io;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mental/constants/constants.dart';
import 'package:mental/model/chantier_view.dart';
import 'package:mental/model/photo.dart';
import 'package:mental/shared/api_rest.dart';
import 'package:mental/shared/tools.dart';

class PhotoChantier extends StatefulWidget {
  final ChantierView chantier;

  const PhotoChantier({required this.chantier}) : super();

  @override
  State<PhotoChantier> createState() => _PhotoChantierState();
}

class _PhotoChantierState extends State<PhotoChantier> {
  TextEditingController nameController = TextEditingController();

  List<Photo> photos = <Photo>[];
  List<PlatformFile> platformFiles = <PlatformFile>[];
  List<io.File> files = <io.File>[];

  @override
  void initState() {
    super.initState();
    getPhotosChantier(widget.chantier.id);
  }



  Future getFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      setState(() {
        platformFiles.addAll(result.files);
      });

      if (kIsWeb) {
      } else {
        setState(() {
          files = result.paths.map((path) => io.File(path!)).toList();
          print(files);
        });
      }

      savePhotoChantier(widget.chantier.id).then((value)  {
       getPhotosChantier(widget.chantier.id);
      });

    } else {
      // User canceled the picker
    }
  }

  Future savePhotoChantier(int idChantier) {
    if (kIsWeb) {
      return APIRest.uploadPhotoWeb(platformFiles, idChantier);
    } else {
      return APIRest.uploadPhotoMobile(files, idChantier);
    }
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
          title: Text('Photo de chantier '+widget.chantier.name),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              child: Text('Ajouter des photos'),
              onPressed: () {
                getFile();
              },
            ),
            ...photos.map(
              (e) => Card(
                elevation: 5,
                child: ListTile(
                  title: Text(e.name),
                  trailing: ElevatedButton(
                    child: Icon(EvaIcons.arrowCircleDownOutline, color: Colors.white),
                    onPressed: () {

                      Tools.open(baseUrlMental + "files/" + e.url);

                    },
                  ),
                ),
              ),
            ),
          ]),
        ));
  }

// set up the AlertDialog
}
