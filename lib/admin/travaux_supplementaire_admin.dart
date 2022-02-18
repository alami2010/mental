import 'package:flutter/material.dart';
import 'package:mental/model/chantier_view.dart';

class TravauxSuppAdmin extends StatefulWidget {
  final ChantierView chantier;

  const TravauxSuppAdmin({required this.chantier}) : super();

  @override
  State<TravauxSuppAdmin> createState() => _TravauxSuppAdminState();
}

class _TravauxSuppAdminState extends State<TravauxSuppAdmin> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      nameController.text = widget.chantier.supp;
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
              maxLines: 15,
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
            ),
          ]),
        ));
  }
}
