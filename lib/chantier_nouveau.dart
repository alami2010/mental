import 'dart:convert';
import 'dart:io' as io;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:mental/model/chantier.dart';
import 'package:mental/shared/tools.dart';

import 'components/multi_select.dart';
import 'model/client.dart';
import 'model/data.dart';
import 'shared/api_rest.dart';

class NouveauChantier extends StatefulWidget {
  const NouveauChantier() : super();

  @override
  State<NouveauChantier> createState() => _NouveauChantierState();
}

class _NouveauChantierState extends State<NouveauChantier> {
  var allClients = <Client>[];
  var client;

  var allTravaux = <Data>[];
  List<Data> travaux = <Data>[];

  var allMateriaux = <Data>[];
  List<Data> materiaux = <Data>[];

  List<PlatformFile> platformFiles = <PlatformFile>[];
  List<io.File> files = <io.File>[];

  TextEditingController nameController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  getData() {
    APIRest.getClients().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        allClients = list.map((model) => Client.fromJson(model)).toList();
      });
    });
    APIRest.getTravaux().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        allTravaux = list.map((model) => Data.fromJson(model)).toList();
      });
    });
    APIRest.getMateriaux().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        allMateriaux = list.map((model) => Data.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void _showMultiSelect(dynamic value, BuildContext context) async {
    switch (value) {
      case 0:
        {
          final List<Data>? results = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return MultiSelect(
                items: allTravaux,
                selectedItems: travaux,
                title: "Selectionnez les travaux",
              );
            },
          );

          print(results);
          if (results != null) {
            setState(() {
              travaux = results;
            });
          }
        }
        break;
      case 1:
        {
          final List<Data>? results = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return MultiSelect(
                items: allMateriaux,
                selectedItems: materiaux,
                title: "Selectionnez les materiaux",
              );
            },
          );

          print(results);
          if (results != null) {
            setState(() {
              materiaux = results;
            });
          }
        }
        break;
      case 2:
        {
          getFile();
        }
        break;
    }
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
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 4;

    return Scaffold(
        appBar: AppBar(
          title: Text('Nouveau Chantier'),
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              onSelected: (value) {
                _showMultiSelect(value, context);
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                const PopupMenuDivider(),
                const PopupMenuItem(
                  child: Text('Ajouter un plan'),
                  value: 2,
                ),
                const PopupMenuItem(
                  child: Text('Ajouter un materiaux'),
                  value: 1,
                ),
                const PopupMenuItem(
                    child: Text('Ajouter un travail'), value: 0),
              ],
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  var chantier = Chantier(
                      -1,
                      nameController.text,
                      adresseController.text,
                      designationController.text,
                      descriptionController.text,
                      materiaux.map((e) => e.id.toString()).join("_"),
                      travaux.map((e) => e.id.toString()).join("_"),
                      client?.name);

                  if (chantier.isValid()) {
                    saveNewChantier(chantier)
                        .then((value) => Navigator.of(context).pop());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Merci de bien remplir le formulaire"),
                    ));
                  }
                },
                child: Icon(EvaIcons.save),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15, top: 15, right: 15),
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(flex: 2, child: Text('Client ')),
                Expanded(
                  flex: 3,
                  child: DropdownButton<Client>(
                    value: client,
                    isDense: true,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    onChanged: (Client? newValue) {
                      setState(() {
                        client = newValue!;
                      });
                    },
                    items: allClients
                        .map<DropdownMenuItem<Client>>((Client value) {
                      return DropdownMenuItem<Client>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nom Chantier',
              ),
            ),
            TextField(
              controller: adresseController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Adresse Chantier',
              ),
            ),
            TextField(
              controller: designationController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Designation Chantier',
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
            ),
            Expanded(
                child: CustomScrollView(slivers: <Widget>[
                  const SliverToBoxAdapter(
                    child: ListTile(
                      leading: Icon(EvaIcons.homeOutline),
                      title: Text('Travaux'),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        final item = travaux[index];
                        return Container(
                          decoration:
                          BoxDecoration(color: Colors.grey.withOpacity(0.8)),
                          child: ListTile(title: Text(item.name)),
                        ); // you can add your available item here
                      },
                      childCount: travaux.length,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: ListTile(
                      leading: Icon(EvaIcons.home),
                      title: Text('Materiaux'),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            final item = materiaux[index];
                        if (index > materiaux.length) return null;
                        return Container(
                          margin: const EdgeInsets.all(2.0),
                          decoration:
                          BoxDecoration(color: Colors.grey.withOpacity(0.8)),
                          child: ListTile(title: Text(item.name)),
                        ); // you can add your available item here
                      },
                      childCount: materiaux.length,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: ListTile(
                      leading: Icon(EvaIcons.file),
                      title: Text('Plan'),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                         final item = platformFiles[index];
                        if (index > platformFiles.length) return null;
                        return Container(
                          margin: const EdgeInsets.all(2.0),
                          decoration:
                          BoxDecoration(color: Colors.grey.withOpacity(0.8)),
                          child: ListTile(
                            title: Text(item.name)
                            ,
                          ),
                        ); // you can add your available item here
                      },
                      childCount: platformFiles.length,
                    ),
                  ),
                ]))
          ]),
        ));
  }

  Future saveNewChantier(Chantier chantier) {
    if (kIsWeb) {
      return APIRest.uploadFileWeb(platformFiles, chantier);
    } else {
      return APIRest.uploadFileMobile(files, chantier);
    }
  }

  Widget _tabSection(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: <Widget>[
          Container(
            child: TabBar(labelColor: Colors.black, tabs: [
              Tab(
                text: "Travaux",
                icon: Icon(EvaIcons.gridOutline),
              ),
              Tab(
                text: "Materiaux",
                icon: Icon(EvaIcons.layers),
              ),
              Tab(
                text: "Plans",
                icon: Icon(EvaIcons.file),
              ),
            ]),
          ),
          Container(
            //Add this to give height
            height: 300,
            child: TabBarView(children: [
              Container(
                child: Tools.getListViewData(travaux),
              ),
              Container(
                child: Tools.getListViewData(materiaux),
              ),
              Container(child: Tools.getListViewFiles(platformFiles)),
            ]),
          ),
        ],
      ),
    );
  }
}
