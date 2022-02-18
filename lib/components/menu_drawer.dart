import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mental/components/list_task_assigned.dart';
import 'package:mental/constants/constants.dart';
import 'package:mental/shared/sp_helper.dart';

import '../main.dart';

class MenuDrawer extends StatelessWidget {
  final List<ListMenuData> initList;

  const MenuDrawer({required this.initList}) : super();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: buildMenuItems(context),
        ),
      ),
    );
  }

  List<Widget> buildMenuItems(BuildContext context) {
    final List<Widget> menuItems = [];
    menuItems.add(DrawerHeader(child: Image.asset(ImageRasterPath.logo)));

    initList.forEach((element) {
      menuItems.add(ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.white70,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: element.color,
              child: element.icon,
            ),
            title: Text(element.label,
                style: TextStyle(fontSize: 18, color: Colors.black87)),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => element.page));
            },
          ),
        ),
      ));
    });
    menuItems.add(ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.white70,
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.black12,
            child: Icon(
              EvaIcons.logOut,
              color: Colors.white,
            ),
          ),
          title: Text("Deconnexion",
              style: TextStyle(fontSize: 18, color: Colors.black87)),
          onTap: () {
            SPHelper helper = SPHelper();
            helper.init().then((value) {
              helper.removeUserType().then((value) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              });
            });
          },
        ),
      ),
    ));
    return menuItems;
  }
}
