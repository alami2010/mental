import 'dart:convert';
import 'dart:io' as io;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:mental/model/chantier.dart';

import '../components/multi_select.dart';
import '../model/client.dart';
import '../model/data.dart';
import '../shared/api_rest.dart';

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

  Future<void> getMateriaux(BuildContext context) async {
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

  Future<void> getTravaux(BuildContext context) async {
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
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15, top: 15, right: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                  Widget>[
            Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  Expanded(flex: 2, child: Text('Client ')),
                  Expanded(
                    flex: 3,
                    child: DropdownButton<Client>(
                      hint: Text('Choissisez un client'),
                      isExpanded: true,
                      value: client,
                      isDense: true,
                      elevation: 16,
                      icon: Icon(EvaIcons.gridOutline),
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
                          child: Text(
                            value.name,
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nom Chantier',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: adresseController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Adresse Chantier',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
            ),
            Expanded(
                child: CustomScrollView(slivers: <Widget>[
              SliverToBoxAdapter(
                child: ListTile(
                  onTap: () {
                    getTravaux(context);
                  },
                  leading: Icon(EvaIcons.homeOutline),
                  title: Text('Travaux'),
                  trailing: Text(
                    'Ajouter un travaux',
                    style: TextStyle(backgroundColor: Colors.blue),
                  ),
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
              SliverToBoxAdapter(
                child: ListTile(
                  onTap: () {
                    getMateriaux(context);
                  },
                  leading: Icon(EvaIcons.home),
                  title: Text('Materiaux'),
                  trailing: Text(
                    'Ajouter un materiaux',
                    style: TextStyle(backgroundColor: Colors.blue),
                  ),
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
              SliverToBoxAdapter(
                child: ListTile(
                  onTap: () {
                    getFile();
                  },
                  leading: Icon(EvaIcons.file),
                  title: Text('Plan'),
                  trailing: Text(
                    'Ajouter un plan',
                    style: TextStyle(backgroundColor: Colors.blue),
                  ),
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
                        title: Text(item.name),
                      ),
                    ); // you can add your available item here
                  },
                  childCount: platformFiles.length,
                ),
              ),
              SliverToBoxAdapter(
                child: ElevatedButton(
                  child: Text('Enregistrer'),
                  onPressed: () {
                    var chantier = Chantier(
                        -1,
                        nameController.text,
                        adresseController.text,
                        descriptionController.text,
                        materiaux.map((e) => e.name.toString()).join("___"),
                        travaux.map((e) => e.name.toString()).join("___"),
                        client?.name);

                    if (chantier.isValid()) {
                      saveNewChantier(chantier)
                          .then((value) => Navigator.of(context).pop());
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Merci de bien remplir le formulaire"),
                      ));
                    }
                  },
                ),
              ),
            ]))
          ]),
        ));
  }

  Future saveNewChantier(Chantier chantier) {
    print(chantier);
    if (kIsWeb) {
      return APIRest.uploadFileWeb(platformFiles, chantier);
    } else {
      return APIRest.uploadFileMobile(files, chantier);
    }
  }
}
