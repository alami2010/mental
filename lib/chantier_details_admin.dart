import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mental/model/chantier_view.dart';
import 'package:mental/shared/tools.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants/constants.dart';

class ChantierDetailsAdmin extends StatefulWidget {
  final ChantierView chantier;

  const ChantierDetailsAdmin({required this.chantier}) : super();

  @override
  State<ChantierDetailsAdmin> createState() => _ChantierDetailsAdminState();
}

class _ChantierDetailsAdminState extends State<ChantierDetailsAdmin> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.chantier.name),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15, top: 15, right: 15),
          child: Column(children: <Widget>[
            Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(EvaIcons.person),
                title: Text(widget.chantier.client),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                onTap: () {
                  Tools.launchMap(widget.chantier.adresse);
                },
                leading: Icon(EvaIcons.pinOutline),
                title: Text(widget.chantier.adresse),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(EvaIcons.text),
                title: Text(widget.chantier.description),
              ),
            ),
            Expanded(
                child: CustomScrollView(slivers: <Widget>[
              const SliverToBoxAdapter(
                child: ListTile(
                  leading: Icon(EvaIcons.homeOutline),
                  title: Text('Travaux'),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    var listMateriaux = widget.chantier.listTravaux;
                    final item = listMateriaux[index];
                    return Container(
                      decoration:
                          BoxDecoration(color: Colors.grey.withOpacity(0.8)),
                      child: ListTile(title: Text(item.name)),
                    ); // you can add your available item here
                  },
                  childCount: widget.chantier.listTravaux.length,
                ),
              ),
              const SliverToBoxAdapter(
                child: ListTile(
                  leading: Icon(EvaIcons.home),
                  title: Text('Materiaux'),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    var listMateriaux = widget.chantier.listMateriaux;
                    final item = listMateriaux[index];
                    if (index > listMateriaux.length) return null;
                    return Container(
                      margin: const EdgeInsets.all(2.0),
                      decoration:
                          BoxDecoration(color: Colors.grey.withOpacity(0.8)),
                      child: ListTile(title: Text(item)),
                    ); // you can add your available item here
                  },
                  childCount: widget.chantier.listMateriaux.length,
                ),
              ),
              const SliverToBoxAdapter(
                child: ListTile(
                  leading: Icon(EvaIcons.file),
                  title: Text('Plan'),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    var listPlans = widget.chantier.listPlans;
                    final item = listPlans[index];
                    if (index > listPlans.length) return null;
                    return Container(
                      margin: const EdgeInsets.all(2.0),
                      decoration:
                          BoxDecoration(color: Colors.grey.withOpacity(0.8)),
                      child: ListTile(
                        title: Text(item.name),
                        onTap: () {
                          Tools.open(baseUrlMental + "/public/files/" + item.url);
                        },
                      ),
                    ); // you can add your available item here
                  },
                  childCount: widget.chantier.listPlans.length,
                ),
              ),
            ]))
          ]),
        ));
  }
}
