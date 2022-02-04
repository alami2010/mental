import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mental/model/chantier_view.dart';
import 'package:mental/shared/api_rest.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ChantierProgressUser extends StatefulWidget {
  final ChantierView chantier;

  const ChantierProgressUser({required this.chantier}) : super();

  @override
  State<ChantierProgressUser> createState() => _ChantierProgressUserState();
}

class _ChantierProgressUserState extends State<ChantierProgressUser> {
  @override
  void initState() {
    super.initState();
  }

  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    var moyenne = (widget.chantier.listTravaux.map((e) => e.progress).reduce((a, b) => a + b) / widget.chantier.listTravaux.length);

    return Scaffold(
        appBar: AppBar(
          title: Text('Avancement sur le chantier: ' + widget.chantier.name),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15, top: 15, right: 15),
          child: Column(children: <Widget>[
            ...widget.chantier.listTravaux.map((e) => Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Slider(
                        value: e.progress.toDouble(),
                        max: 100,
                        divisions: 5,
                        label: e.progress.toString(),
                        onChanged: (double value) {
                          setState(() {
                            e.progress = value.toInt();
                          });
                        },
                      ),
                      ListTile(
                        leading: Icon(EvaIcons.person),
                        title: Text(e.name),
                      ),
                    ],
                  ),
                )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              child: Text('Enregistrer'),
              onPressed: () {
                saveProgress();
              },
            ),
            SizedBox(height: 100), // give it width

            CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 13.0,
              animation: true,
              percent: moyenne/100,
              center: new Text(
                moyenne.toString()+"%",
                style:
                new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              footer: new Text(
                "Avancement",
                style:
                new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.blue,
            )
          ]),
        ));
  }

  void saveProgress() {
    print("save");
    APIRest.saveProgress(widget.chantier.listTravaux,widget.chantier.id).then((value){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Avancement bien enregisté')));
    });

  }
}
