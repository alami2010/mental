import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mental/shared/api_rest.dart';

import 'model/client.dart';
import 'model/data.dart';

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

  void removeMateriaux(int index, int? id) {
    setState(() {
      APIRest.deletMateriaux(id!).then((response) {
        setState(() {
          materiaux.removeAt(index);
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
        body: Padding(
          padding: EdgeInsets.only(left: 15, top: 15, right: 15),
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
            Expanded(
                child: ListView.builder(
                    itemCount: materiaux.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 40,
                        margin: EdgeInsets.all(2),
                        color: Colors.blue.withOpacity(0.4),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 6, // 20%
                                  child: Text(
                                    '${materiaux[index].name} ',
                                  )),
                              Expanded(
                                flex: 1, // 20%
                                child: ElevatedButton(
                                  child:
                                      Icon(EvaIcons.trash, color: Colors.white),
                                  onPressed: () {
                                    showAlertDialog(
                                        context, index, materiaux[index].id);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }))
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
        removeMateriaux(index, id);
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
