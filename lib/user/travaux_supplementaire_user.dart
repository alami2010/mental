import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mental/model/chantier_view.dart';
import 'package:mental/shared/api_rest.dart';

class TravauxSupp extends StatefulWidget {
  final ChantierView chantier;

  const TravauxSupp({required this.chantier}) : super();

  @override
  State<TravauxSupp> createState() => _TravauxSuppState();
}

class _TravauxSuppState extends State<TravauxSupp> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      nameController.text = widget.chantier.supp;
    });
  }

  void saveTravauxSupp() {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("le text est vide"),
      ));
      return;
    }
    APIRest.saveTravauxSupp(nameController.text, widget.chantier.id)
        .then((value) {
      var material = json.decode(value.body);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Travaux Supplémenatire'),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15, top: 15, right: 15),
          child: Column(children: <Widget>[
            TextField(
              maxLines: 10,
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              child: Text('Sauvegarder'),
              onPressed: () {
                saveTravauxSupp();
              },
            ),
          ]),
        ));
  }
}
