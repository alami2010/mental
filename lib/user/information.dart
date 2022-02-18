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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageRasterPath.backGroundPhoto_2),
            fit: BoxFit.fill,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 50),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      height: 150,
                      child: Image.asset(ImageRasterPath.logo)),
                  const SizedBox(height: 50),
                  buildContainerText("3H Métal"),
                  const SizedBox(height: 10),
                  buildContainerText(
                    "SASU Capital",

                  ),
                  const SizedBox(height: 10),
                  buildContainerText(
                    "1000 €",
                   ),
                  const SizedBox(height: 40),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      onTap: () {
                        Tools.launchMap(
                            "57 Rue des boutons d'or dd 33370 YVRAC");
                      },
                      leading: Icon(EvaIcons.pin,color: Colors.green,),
                      title: Text("57 Rue des boutons d'or dd 33370 YVRAC"),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      onTap: () {
                        Tools.open('https://www.3hmetal.fr');
                      },
                      leading: Icon(EvaIcons.globe2Outline,color: Colors.blue,),
                      title: Text('https://www.3hmetal.fr'),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      onTap: () {
                        Tools.open('tel:0625812179');
                      },
                      leading: Icon(EvaIcons.phone,color: Colors.red,),
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

  Container buildContainerText(String text) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
