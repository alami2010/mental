import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mental/model/chantier_view.dart';
import 'package:mental/shared/api_rest.dart';

import 'chantier_action_user.dart';

class ChantierStart extends StatefulWidget {
  const ChantierStart() : super();

  @override
  State<ChantierStart> createState() => _ChantierStartState();
}

class _ChantierStartState extends State<ChantierStart> {
  var chantiers = <ChantierView>[];

  @override
  void initState() {
    super.initState();
    getChantiers();
  }

  getChantiers() {
    APIRest.chantiersStartStatus().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        chantiers = list.map((model) => ChantierView.fromJson(model)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chantiers en cours'),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15, top: 15, right: 15),
          child: Column(children: <Widget>[
            ...chantiers.map((e) => Card(
                  elevation: 5,
                  child: Container(
                    decoration: BoxDecoration(color: e.getStatusColor()),
                    child: ListTile(
                      onTap: () => Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) =>
                                  ChantierActionUser(chantier: e)))
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
        ));
  }
}
