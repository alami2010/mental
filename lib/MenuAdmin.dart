import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:mental/chantier_done.dart';
import 'package:mental/shared/api_rest.dart';

import 'chantier_new_start.dart';
import 'chantier_nouveau.dart';
import 'components/list_task_assigned.dart';
import 'constants/constants.dart';
import 'list_client.dart';
import 'list_materiaux.dart';
import 'list_travaux.dart';
import 'materiaux_manquant.dart';
import 'model/data.dart';

class MenuAdmin extends StatefulWidget {
  const MenuAdmin({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MenuAdmin> createState() => _MenuAdminState();
}

class _MenuAdminState extends State<MenuAdmin> {
  var materiauxManquat = <Data>[];

  var listMenu = [];

  List<ListMenuData> initListMenu() {
    return [
      const ListMenuData(
          icon: Icon(EvaIcons.home, color: Colors.blue),
          label: "Liste Travaux",
          page: ListTravaux()),
      ListMenuData(
        icon: const Icon(EvaIcons.homeOutline, color: Colors.blue),
        label: "Liste matériaux",
        page: ListMateriaux(),
      ),
      const ListMenuData(
        icon: Icon(EvaIcons.people, color: Colors.blue),
        label: "Liste clients",
        page: ListClient(),
      ),
      const ListMenuData(
        icon: Icon(EvaIcons.plusCircle, color: Colors.blue),
        label: "Nouveau chantier",
        page: NouveauChantier(),
      ),
      const ListMenuData(
        icon: Icon(EvaIcons.pieChart, color: Colors.blue),
        label: "Chantier en cours",
        page: ChantierNewStart(),
      ),
      ListMenuData(
          icon: Icon(EvaIcons.alertCircle, color: Colors.blue),
          label: "Matérieux manquants",
          page: MateriauxManquant(),
          alert: materiauxManquat.length == 0,
          showTrailing: true,
          notifyParent: getMateriauxManquant),
      const ListMenuData(
        icon: Icon(EvaIcons.archive, color: Colors.blue),
        label: "Chantiers archivés",
        page: ChantierDone(),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    getMateriauxManquant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 50),
              Container(height: 150, child: Image.asset(ImageRasterPath.logo)),
              const SizedBox(height: 50),
              ...listMenu
                  .asMap()
                  .entries
                  .map((e) => ListMenu(
                        data: e.value,
                      ))
                  .toList(),
              ElevatedButton(onPressed: () {
                print('test me');

                FlutterAppBadger.isAppBadgeSupported().then((value) =>  print(value));

                  print(FlutterAppBadger.isAppBadgeSupported());
                FlutterAppBadger.updateBadgeCount(1);
              }, child: Text('test me'))
            ],
          ),
        ),
      ),
    );
  }

  getMateriauxManquant() {
    APIRest.getMateriauxManquant().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        materiauxManquat = list.map((model) => Data.fromJson(model)).toList();
        listMenu = initListMenu();
      });
    });
  }
}
