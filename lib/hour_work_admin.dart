import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mental/model/chantier_view.dart';
import 'package:mental/model/horaire.dart';
import 'package:mental/shared/api_rest.dart';

class HourWorkAdmin extends StatefulWidget {
  final ChantierView chantier;

  const HourWorkAdmin({required this.chantier}) : super();

  @override
  State<HourWorkAdmin> createState() => _HourWorkAdminState();
}

class _HourWorkAdminState extends State<HourWorkAdmin> {
  TextEditingController debutMatinController = TextEditingController();
  TextEditingController finMatinController = TextEditingController();
  TextEditingController debutSoirController = TextEditingController();
  TextEditingController finSoirController = TextEditingController();

  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    setState(() {});
  }




  @override
  Widget build(BuildContext context) {
    print(widget.chantier.horaires);
    return Scaffold(
        appBar: AppBar(
          title: Text('Temps de travail'),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15, top: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[

              const SizedBox(height: 10),

              SizedBox(height: 20),
              ...widget.chantier.horaires.map((e) => Card(
                    elevation: 5,
                    child: Container(
                      child: ListTile(
                        leading: Icon(EvaIcons.clock),
                        title: Text(
                            getDyaName(e.weekday) + ' ' + e.date.split(' ')[0]),
                        subtitle: Text(e.debutMatin +
                            '-' +
                            e.finMatin +
                            '  ' +
                            e.debutSoir +
                            '-' +
                            e.finSoir),
                      ),
                    ),
                  ))
            ]),
          ),
        ));
  }

  String getDyaName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Lundi';
      case 2:
        return 'Mardi';
      case 3:
        return 'Mercredi';
      case 4:
        return 'Jeudi ';
      case 5:
        return 'Vendredi';
      case 6:
        return 'Samedi ';
      case 7:
      default:
        return 'Dimanche';
    }
  }
}

// This class simply decorates a row of widgets.
class _DatePickerItem extends StatelessWidget {
  const _DatePickerItem({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0,
          ),
          bottom: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}
