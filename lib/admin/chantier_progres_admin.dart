import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mental/model/chantier_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ChantierProgressAdmin extends StatefulWidget {
  final ChantierView chantier;

  const ChantierProgressAdmin({required this.chantier}) : super();

  @override
  State<ChantierProgressAdmin> createState() => _ChantierProgressAdminState();
}

class _ChantierProgressAdminState extends State<ChantierProgressAdmin> {
  @override
  void initState() {
    super.initState();
  }

  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    var moyenne = (widget.chantier.listTravaux
            .map((e) => e.progress)
            .reduce((a, b) => a + b) /
        widget.chantier.listTravaux.length);

    return Scaffold(
        appBar: AppBar(
          title: Text('Avancement sur le chantier: ' + widget.chantier.name),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15, top: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              ...widget.chantier.listTravaux.map((e) => Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 50,
                          animation: true,
                          lineHeight: 20.0,
                          animationDuration: 2000,
                          percent: e.progress / 100,
                          center: Text(e.progress.toString() + "%"),
                          progressColor: Colors.greenAccent,
                        ),
                        ListTile(
                          leading: Icon(EvaIcons.person),
                          title: Text(e.name),
                          trailing: Text(e.progress.toString() + '%'),
                        ),
                      ],
                    ),
                  )),

              SizedBox(width: 100), // give it width

              CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 13.0,
                animation: true,
                percent: moyenne / 100,
                center: new Text(
                  moyenne.toString() + "%",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer: new Text(
                  "Avancement",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.blue,
              ),
            ]),
          ),
        ));
  }
}
