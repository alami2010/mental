import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mental/chantier_details.dart';
import 'package:mental/model/chantier_view.dart';


class ChantierAction extends StatefulWidget {
  final ChantierView chantier;

  const ChantierAction({required this.chantier}) : super();

  @override
  State<ChantierAction> createState() => _ChantierActionState();
}

class _ChantierActionState extends State<ChantierAction> {
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
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ChantierDetails(chantier: widget.chantier)));
                },
                leading: Icon(EvaIcons.layers),
                title: Text('Information chantier'),
              ),
            ),
            const Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(EvaIcons.star),
                title: Text('Avancement travaux'),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(EvaIcons.homeOutline),
                title: Text('Matériaux manquants'),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(EvaIcons.clock),
                title: Text('Temps de travail'),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(EvaIcons.colorPicker),
                title: Text('Photo'),
              ),
            ),

          ]),
        ));
  }
}
