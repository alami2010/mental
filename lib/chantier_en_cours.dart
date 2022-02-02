import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mental/chantier_action.dart';
import 'package:mental/chantier_details.dart';
import 'package:mental/model/chantier_view.dart';
import 'package:mental/shared/api_rest.dart';

class ChantierEnCours extends StatefulWidget {
  const ChantierEnCours() : super();

  @override
  State<ChantierEnCours> createState() => _ChantierEnCoursState();
}

class _ChantierEnCoursState extends State<ChantierEnCours> {
  var chantiers = <ChantierView>[];

  @override
  void initState() {
    super.initState();
    getChantiers();
  }

  getChantiers() {
    APIRest.chantiers().then((response) {
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
          title: Text('Chantier en cours'),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15, top: 15, right: 15),
          child: Column(children: <Widget>[
            Expanded(
                child: ListView.builder(
                    itemCount: chantiers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 40,
                        margin: EdgeInsets.all(2),
                        color: chantiers[index].status == 'NEW'
                            ? Colors.blue.withOpacity(0.4)
                            : Colors.green.withOpacity(0.4),
                        child: InkWell(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ChantierAction(
                                      chantier: chantiers[index]))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 6, // 20%
                                  child: Text(
                                    '${chantiers[index].name} ',
                                  )),
                              Expanded(
                                  flex: 1, // 20%
                                  child: Icon(chantiers[index].status == 'NEW'
                                      ? EvaIcons.lockOutline
                                      : EvaIcons.loaderOutline)),
                              Expanded(
                                  flex: 2, // 20%
                                  child: Text(
                                    chantiers[index].status == 'NEW'
                                        ? 'Nouveau'
                                        : 'En cours',
                                  )),
                            ],
                          ),
                        ),
                      );
                    }))
          ]),
        ));
  }
}
