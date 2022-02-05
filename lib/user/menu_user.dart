import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mental/model/data.dart';
import 'package:mental/page_vide.dart';
import 'package:mental/shared/api_rest.dart';
import 'package:mental/user/chantier_start.dart';
import 'package:mental/user/information.dart';

import '../components/list_task_assigned.dart';
import '../constants/constants.dart';
import 'materiaux_manquant_user.dart';

class UserMenu extends StatefulWidget {
  const UserMenu({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<UserMenu> createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {
  var list = [];
  var materiauxManquat = <Data>[];

  List<ListMenuData> initList() {
    return [
      const ListMenuData(
          icon: Icon(EvaIcons.home, color: Colors.blue),
          label: "3H Métal",
          page: Information()),
      ListMenuData(
        icon: const Icon(EvaIcons.homeOutline, color: Colors.blue),
        label: "Chantier en cours",
        page: ChantierStart(),
      ),
      const ListMenuData(
        icon: Icon(EvaIcons.alertCircle, color: Colors.blue),
        label: "Matérieux manquants",
        page: MateriauxManquantUser(),
      ),
      const ListMenuData(
        icon: Icon(EvaIcons.alertCircle, color: Colors.blue),
        label: "TVA",
        page: PageEmpty(),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    getMateriauxManquant();
    list = initList();
  }

  getMateriauxManquant() {
    APIRest.getAllMateriauxManquant().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        materiauxManquat = list.map((model) => Data.fromJson(model)).toList();
      });
    });
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
              ...list
                  .asMap()
                  .entries
                  .map((e) => ListMenu(
                        data: e.value,
                      ))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
