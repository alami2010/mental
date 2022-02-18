import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mental/components/menu_drawer.dart';
import 'package:mental/model/data.dart';
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
          color: Colors.greenAccent,
          icon: Icon(EvaIcons.home, color: Colors.white),
          label: "3H Métal",
          page: Information()),
      const ListMenuData(
        color: Colors.blueAccent,
        icon: Icon(EvaIcons.homeOutline, color: Colors.white),
        label: "Chantier en cours",
        page: ChantierStart(),
      ),
      const ListMenuData(
        color: Colors.redAccent,
        icon: Icon(EvaIcons.alertCircle, color: Colors.white),
        label: "Matérieux manquants",
        page: MateriauxManquantUser(),
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
      drawer: MenuDrawer(initList: initList()),
      appBar: AppBar(
        title: Text("3H Mental"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageRasterPath.backGroundPhoto),
            fit: BoxFit.fill,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 50),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,

                    image: DecorationImage(
                      image: AssetImage(ImageRasterPath.logo),
                      fit: BoxFit.fill,
                    ),
                  ),
                  height: 150,
                  child: Image.asset(ImageRasterPath.logo)),
              const SizedBox(height: 50),
              ...list
                  .asMap()
                  .entries
                  .map((e) => CardMenu(
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
