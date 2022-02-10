import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mental/model/data.dart';
import 'package:mental/shared/api_rest.dart';
import 'package:mental/shared/tools.dart';

class MateriauxManquantUser extends StatefulWidget {
  const MateriauxManquantUser() : super();

  @override
  State<MateriauxManquantUser> createState() => _MateriauxManquantUserState();
}

class _MateriauxManquantUserState extends State<MateriauxManquantUser> {
  TextEditingController nameController = TextEditingController();
  var materiauxManquat = <Data>[];

  @override
  void initState() {
    super.initState();
    getMateriauxManquant();
  }

  void createMateriauxManquant() {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("le text est vide"),
      ));
      return;
    }
    APIRest.createMateriauxManquant(nameController.text).then((value) {
      var material = json.decode(value.body);
      setState(() {
        materiauxManquat.insert(0, Data.fromJson(material));
      });
    });
  }

  getMateriauxManquant() {
    APIRest.getAllMateriauxManquant().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        materiauxManquat = list.map((model) => Data.fromJson(model)).toList();
      });
    });
  }

  _saveQte(int id, int qte) {
    APIRest.saveQte(id, qte).then((response) {
      Tools.showMessage(context, "Quantité bien enregistré");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Liste Materiaux manquants'),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15, top: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              ...materiauxManquat.map((e) => Card(
                    elevation: 5,
                    child: ListTile(
                      leading: Container(
                          width: 2 * MediaQuery.of(context).size.width / 8,
                          child: Text(e.name)),
                      title: Center(
                        child: Container(
                          width: 2 * MediaQuery.of(context).size.width / 5,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    if (e.qte > 0) {
                                      e.qte--;
                                    }
                                  });
                                },
                                color: Colors.green,
                              ),
                              Text(e.qte.toString()),
                              IconButton(
                                icon: Icon(Icons.add),
                                color: Colors.green,
                                onPressed: () {
                                  setState(() {
                                    e.qte++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      trailing: Container(
                        width: MediaQuery.of(context).size.width / 6,
                        child: IconButton(
                          icon: new Icon(Icons.save),
                          highlightColor: Colors.blue,
                          onPressed: () {
                            _saveQte(e.id, e.qte);
                          },
                        ),
                      ),
                    ),
                  ))

            ]),
          ),
        ));
  }
}
