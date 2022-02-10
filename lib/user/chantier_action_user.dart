import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mental/chantier_details_admin.dart';
import 'package:mental/model/chantier_view.dart';
import 'package:mental/shared/api_rest.dart';
import 'package:mental/user/chantier_progres_user.dart';
import 'package:mental/user/photo_chantier.dart';
import 'package:mental/user/travaux_supplementaire_user.dart';

import 'hour_work.dart';

class ChantierActionUser extends StatefulWidget {
  final ChantierView chantier;

  const ChantierActionUser({required this.chantier}) : super();

  @override
  State<ChantierActionUser> createState() => _ChantierActionUserState();
}

class _ChantierActionUserState extends State<ChantierActionUser> {
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
                          ChantierProgressUser(chantier: widget.chantier)));
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
                          TravauxSupp(chantier: widget.chantier)));
                },
                leading: Icon(EvaIcons.homeOutline),
                title: Text('Travaux Supplémentaire'),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          HourWorkUser(chantier: widget.chantier)));
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
                          PhotoChantier(chantier: widget.chantier)));
                },
                leading: Icon(EvaIcons.colorPicker),
                title: Text('Photos'),
              ),
            )
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
