import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mental/shared/api_rest.dart';

import '../model/data.dart';

class ListMateriaux extends StatefulWidget {
  const ListMateriaux() : super();

  @override
  State<ListMateriaux> createState() => _ListMateriauxState();
}

class _ListMateriauxState extends State<ListMateriaux> {
  TextEditingController nameController = TextEditingController();
  var materiaux = <Data>[];

  @override
  void initState() {
    super.initState();
    getMateriaux();
  }

  void createMateriaux() {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Sending Message"),
      ));
      return;
    }
    APIRest.createMateriaux(nameController.text).then((value) {
      var material = json.decode(value.body);
      setState(() {
        materiaux.insert(0, Data.fromJson(material));
      });
    });
  }

  void removeMateriaux(int? id) {
    setState(() {
      APIRest.deletMateriaux(id!).then((response) {
        setState(() {
          materiaux = materiaux.where((element) => element.id != id).toList();
        });
      });
    });
  }

  getMateriaux() {
    APIRest.getMateriaux().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        materiaux = list.map((model) => Data.fromJson(model)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Liste Materiaux'),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Materiel',
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              child: Text('Ajouter'),
              onPressed: () {
                createMateriaux();
              },
            ),
            ...materiaux.map(
              (e) => Card(
                elevation: 5,
                child: ListTile(
                  title: Text(e.name),
                  trailing: ElevatedButton(
                    child: Icon(EvaIcons.trash, color: Colors.white),
                    onPressed: () {
                      showAlertDialog(context, -1, e.id);
                    },
                  ),
                ),
              ),
            ),
          ]),
        ));
  }

  showAlertDialog(BuildContext context, int index, int? id) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Sortir"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
        print(index.toString());
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
        removeMateriaux(id);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text("Etes vous sure de supprimer ce Materiaux?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
