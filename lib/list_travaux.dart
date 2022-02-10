import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mental/model/data.dart';
import 'package:mental/shared/api_rest.dart';

class ListTravaux extends StatefulWidget {
  const ListTravaux() : super();

  @override
  State<ListTravaux> createState() => _ListTravauxState();
}

class _ListTravauxState extends State<ListTravaux> {
  var travaux = <Data>[];
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getTravaux();
  }

  void createTravail() {
    APIRest.createTravail(nameController.text).then((value) {
      var travail = json.decode(value.body);
      setState(() {
        travaux.insert(0, Data.fromJson(travail));
      });
    });
  }

  void removeTravail(int? id) {
    setState(() {
      APIRest.deletTravail(id!).then((response) {
        setState(() {
          travaux = travaux.where((element) => element.id != id).toList();
        });
      });
    });
  }

  getTravaux() {
    APIRest.getTravaux().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        travaux = list.map((model) => Data.fromJson(model)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Liste Travaux'),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Travail',
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              child: Text('Ajouter'),
              onPressed: () {
                createTravail();
              },
            ),
            ...travaux.map(
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
            )
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
        removeTravail(id);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text("Etes vous sure de supprimer ce travail?"),
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
