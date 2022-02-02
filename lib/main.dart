import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mental/chantier_en_cours.dart';
import 'package:mental/components/list_task_assigned.dart';
import 'package:mental/list_materiaux.dart';
import 'package:mental/list_travaux.dart';
import 'package:mental/page_vide.dart';
import 'package:mental/home.dart';

import 'constants/assets_path.dart';
import 'list_client.dart';
import 'chantier_nouveau.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class AdminMenu extends StatefulWidget {
  const AdminMenu({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<AdminMenu> createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {
  final weeklyTask = [
    const ListTaskAssignedData(
        icon: Icon(EvaIcons.home, color: Colors.blue),
        label: "Liste Travaux",
        page: ListTravaux()),
    ListTaskAssignedData(
      icon: const Icon(EvaIcons.homeOutline, color: Colors.blue),
      label: "Liste matériaux",
      page: ListMateriaux(),
    ),
    const ListTaskAssignedData(
      icon: Icon(EvaIcons.people, color: Colors.blue),
      label: "Liste clients",
      page: ListClient(),
    ),
    const ListTaskAssignedData(
      icon: Icon(EvaIcons.plusCircle, color: Colors.blue),
      label: "Nouveau chantier",
      page: NouveauChantier(),
    ),
    const ListTaskAssignedData(
      icon: Icon(EvaIcons.pieChart, color: Colors.blue),
      label: "Chantier en cours",
      page: ChantierEnCours(),
    ),
    const ListTaskAssignedData(
      icon: Icon(EvaIcons.alertCircle, color: Colors.blue),
      label: "Matérieux manquants",
      page: PageEmpty(),
    ),
    const ListTaskAssignedData(
      icon: Icon(EvaIcons.archive, color: Colors.blue),
      label: "Chantiers archivés",
      page: PageEmpty(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 50),
              Container(height: 150, child: Image.asset(ImageRasterPath.logo)),
              const SizedBox(height: 50),
              ...weeklyTask
                  .asMap()
                  .entries
                  .map((e) => ListTaskAssigned(
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
