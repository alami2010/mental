import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mental/shared/api_rest.dart';
import 'package:mental/shared/tools.dart';

import '../model/data.dart';

class MateriauxManquant extends StatefulWidget {
  const MateriauxManquant() : super();

  @override
  State<MateriauxManquant> createState() => _MateriauxManquantState();
}

class _MateriauxManquantState extends State<MateriauxManquant> {
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
      Tools.showMessage(context,"Quantité bien enregistré");
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
                  createMateriauxManquant();
                },
              ),
              ...materiauxManquat.map((e) => Card(
                    elevation: 5,
                    child: ListTile(
                      leading: Container(
                          width: 2 * MediaQuery.of(context).size.width / 8,
                          child: Text(e.name)),
                      title: Container(
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
/*
              Expanded(
                  child: ListView.builder(
                      itemCount: materiauxManquat.length,
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
                                      '${materiauxManquat[index].name} ',
                                    )),
                                Expanded(
                                  flex: 1, // 20%
                                  child: ElevatedButton(
                                    child:
                                        Icon(EvaIcons.trash, color: Colors.white),
                                    onPressed: () {

                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }))
*/
            ]),
          ),
        ));
  }
}
