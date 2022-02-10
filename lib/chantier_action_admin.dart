import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mental/chantier_details_admin.dart';
import 'package:mental/chantier_progres_admin.dart';
import 'package:mental/model/chantier_view.dart';
import 'package:mental/photo_chantier_admin.dart';
import 'package:mental/shared/api_rest.dart';
import 'package:mental/travaux_supplementaire_admin.dart';

import 'hour_work_admin.dart';

class ChantierActionAdmin extends StatefulWidget {
  final ChantierView chantier;

  const ChantierActionAdmin({required this.chantier}) : super();

  @override
  State<ChantierActionAdmin> createState() => _ChantierActionAdminState();
}

class _ChantierActionAdminState extends State<ChantierActionAdmin> {
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
              child: Container(
                decoration:
                    new BoxDecoration(color: widget.chantier.getStatusColor()),
                child: ListTile(
                  leading: widget.chantier.getStatusIcon(),
                  title: Text(widget.chantier.getStatusName()),
                ),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ChantierDetailsAdmin(chantier: widget.chantier)));
                },
                leading: Icon(EvaIcons.layers),
                title: Text('Information chantier'),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ChantierProgressAdmin(chantier: widget.chantier)));
                },
                leading: Icon(EvaIcons.star),
                title: Text('Avancement travaux'),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            TravauxSuppAdmin(chantier: widget.chantier)));
                  },
                leading: Icon(EvaIcons.homeOutline),
                title: Text('Travaux supplémentaire'),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          HourWorkAdmin(chantier: widget.chantier)));
                },
                leading: Icon(EvaIcons.clock),
                title: Text('Temps de travail'),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          PhotoChantierAdmin(chantier: widget.chantier)));
                },
                leading: Icon(EvaIcons.colorPicker),
                title: Text('Photos'),
              ),
            ),
            buildCardChangeStatus(),
          ]),
        ));
  }

  Widget buildCardChangeStatus() {
    if (widget.chantier.status == 'NEW') {
      return Card(
        elevation: 5,
        child: ListTile(
          onTap: () {
            showAlertDialog(
                context, 'Etes vous sur de demarer le chantier', 'START');
          },
          leading: Icon(EvaIcons.save),
          title: Text('Demarer le chantier'),
        ),
      );
    } else if (widget.chantier.status == 'START') {
      return Card(
        elevation: 5,
        child: ListTile(
          onTap: () {
            showAlertDialog(
                context, "Etes vous sur d'archiver le chantier", 'DONE');
          },
          leading: Icon(EvaIcons.save),
          title: Text('Archiver le chantier'),
        ),
      );
    }

    return Center();
  }

  showAlertDialog(BuildContext context, String label, String status) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Sortir"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
        APIRest.changeChantierStatus(widget.chantier.id, status).then((value) {
          setState(() {
            widget.chantier.status = status;
          });
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text(label),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
