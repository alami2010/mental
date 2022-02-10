import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mental/constants/constants.dart';
import 'package:mental/shared/tools.dart';

class Information extends StatefulWidget {
  const Information({Key? key}) : super(key: key);

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 50),
                  Container(
                      height: 150, child: Image.asset(ImageRasterPath.logo)),
                  const SizedBox(height: 50),
                  Text(
                    "3H Métal",
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "SASU Capital",
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "1000 €",
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 40),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      onTap: () {
                        Tools.launchMap("57 Rue des boutons d'or dd 33370 YVRAC");
                      },
                      leading: Icon(EvaIcons.pin),
                      title: Text("57 Rue des boutons d'or dd 33370 YVRAC"),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      onTap: () {
                        Tools.open('https://www.3hmetal.fr');
                      },
                      leading: Icon(EvaIcons.globe2Outline),
                      title: Text('https://www.3hmetal.fr'),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      onTap: () {
                        Tools.open('tel:0625812179');
                      },
                      leading: Icon(EvaIcons.phone),
                      title: Text('Appeler'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
