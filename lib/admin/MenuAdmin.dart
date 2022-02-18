import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:mental/components/list_task_assigned.dart';
import 'package:mental/components/menu_drawer.dart';
import 'package:mental/constants/constants.dart';
import 'package:mental/model/data.dart';
import 'package:mental/shared/api_rest.dart';

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

  var listMenu = initListMenu();

  @override
  void initState() {
    super.initState();
    getMateriauxManquant();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: MenuDrawer(initList: initListMenu()),
      appBar: AppBar(
        title: Text("3H Mental"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 50),
                Container(height: 150, child: Image.asset(ImageRasterPath.logo)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardMenu(data: listMenu[0]),
                    CardMenu(data: listMenu[1]),
                        CardMenu(data: listMenu[2]),
                        CardMenu(data: listMenu[3]),

                        CardMenu(data: listMenu[4]),
                        CardMenu(data: listMenu[5])
                   ,
                        CardMenu(data: listMenu[6]),


                  ],
                ),

                const SizedBox(height: 50),
              ],
            ),
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
