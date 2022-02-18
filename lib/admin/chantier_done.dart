import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mental/admin/chantier_action_admin.dart';
import 'package:mental/model/chantier_view.dart';
import 'package:mental/shared/api_rest.dart';

class ChantierDone extends StatefulWidget {
  const ChantierDone() : super();

  @override
  State<ChantierDone> createState() => _ChantierDoneState();
}

class _ChantierDoneState extends State<ChantierDone> {
  var chantiers = <ChantierView>[];
  var chantiersFiltred = <ChantierView>[];

  var allClients = <String>[];
  var client;

  @override
  void initState() {
    super.initState();
    getChantiers();
  }

  getChantiers() {
    APIRest.chantiersDoneStatus().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        chantiers = list.map((model) => ChantierView.fromJson(model)).toList();
        chantiersFiltred = chantiers;
        allClients = chantiers.map((e) => e.client).toSet().toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chantiers Archivés'),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15, top: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(
                height: 50,
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 2, child: Text('Client ')),
                    Expanded(
                      flex: 3,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: client,
                        isDense: true,
                        elevation: 16,
                        icon: Icon(EvaIcons.gridOutline),
                        style: const TextStyle(color: Colors.black),
                        onChanged: (String? newValue) {
                          setState(() {
                            client = newValue!;

                            chantiersFiltred = chantiers
                                .where((element) => element.client == newValue)
                                .toList();
                          });
                        },
                        items: allClients
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              ...chantiersFiltred.map((e) => Card(
                    elevation: 5,
                    child: Container(
                      decoration: BoxDecoration(color: e.getStatusColor()),
                      child: ListTile(
                        onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) =>
                                    ChantierActionAdmin(chantier: e)))
                            .then((value) {
                          getChantiers();
                        }),
                        leading: Icon(EvaIcons.layers),
                        title: Text(e.name),
                        trailing: e.getStatusIcon(),
                      ),
                    ),
                  )),
            ]),
          ),
        ));
  }
}
