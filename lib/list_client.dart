import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mental/shared/api_rest.dart';

import 'model/client.dart';

class ListClient extends StatefulWidget {
  const ListClient() : super();

  @override
  State<ListClient> createState() => _ListClientState();
}

class _ListClientState extends State<ListClient> {
  var clients = <Client>[];

  TextEditingController nameController = TextEditingController();
  late List<bool> isSelected;

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
    getClient();
  }

  void addClient(bool isProfessional) {
    APIRest.createClient(nameController.text, isProfessional).then((value) {
      var client = json.decode(value.body);
      setState(() {
        clients.insert(0, Client.fromJson(client));
      });
    });
  }

  void removeClient( int id) {
    setState(() {
      APIRest.deleteClient(id).then((response) {
        setState(() {
           clients = clients.where((element) => element.id != id).toList();

        });
      });
    });
  }

  getClient() {
    APIRest.getClients().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        clients = list.map((model) => Client.fromJson(model)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Liste Client'),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Client',
              ),
            ),
            ToggleButtons(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Professionnel',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Particulier',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
              onPressed: (int index) {
                print(index);
                setState(() {
                  for (int buttonIndex = 0;
                      buttonIndex < isSelected.length;
                      buttonIndex++) {
                    if (buttonIndex == index) {
                      isSelected[buttonIndex] = !isSelected[buttonIndex];
                    } else {
                      isSelected[buttonIndex] = false;
                    }
                  }
                });
              },
              isSelected: isSelected,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              child: Text('Ajouter'),
              onPressed: () {
                addClient(isSelected[0]);
              },
            ),
            ...clients.map(
                  (e) => Card(
                elevation: 5,
                child: ListTile(
                  leading: e.professional
                      ? Icon(EvaIcons.personDone)
                      : Icon(EvaIcons.person),
                  title: Text(e.name),
                  trailing: ElevatedButton(
                    child: Icon(EvaIcons.trash, color: Colors.white),
                    onPressed: () {
                      showAlertDialog(context, e.id);
                    },
                  ),
                ),
              ),
            ),

           ]),
        ));
  }

  showAlertDialog(BuildContext context, int id) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Sortir"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog

      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
        removeClient(id);
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
