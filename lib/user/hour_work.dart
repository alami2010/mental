import 'dart:convert';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mental/model/chantier_view.dart';
import 'package:mental/model/horaire.dart';
import 'package:mental/shared/api_rest.dart';

class HourWorkUser extends StatefulWidget {
  final ChantierView chantier;

  const HourWorkUser({required this.chantier}) : super();

  @override
  State<HourWorkUser> createState() => _HourWorkUserState();
}

class _HourWorkUserState extends State<HourWorkUser> {
  DateTime date = DateTime.now();
  DateTime? dateDebutMatin = DateTime(0, 0, 0, 8, 00);
  DateTime dateDebutSoir = DateTime(0, 0, 0, 14, 00);
  DateTime dateFinMatin = DateTime(0, 0, 0, 12, 00);
  DateTime dateFinSoir = DateTime(0, 0, 0, 18, 00);

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  void saveHoraire() {
    APIRest.saveHoraire(
            Horaire(
                -1,
                date.toString(),
                dateDebutMatin.toString(),
                dateDebutSoir.toString(),
                dateDebutSoir.toString(),
                dateFinSoir.toString(),
                date.weekday),
            widget.chantier.id)
        .then((value) {
      var horaire = Horaire.fromJson(json.decode(value.body));
      print(horaire);
      setState(() {
        final Event event = Event(
          title: 'Chantier ' + widget.chantier.name,
          description: buildHours(horaire),
          location: widget.chantier.adresse,
          startDate: DateTime.now(),
          endDate: DateTime.now().add(Duration(hours: 1)),
          iosParams: const IOSParams(
            reminder: Duration(
                /* Ex. hours:1 */), // on iOS, you can set alarm notification after your event.
          ),
          androidParams: const AndroidParams(
            emailInvites: [], // on Android, you can add invite emails to your event.
          ),
        );
        Add2Calendar.addEvent2Cal(event);
        widget.chantier.horaires.insert(0, horaire);
      });
    });
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.chantier.horaires);
    return Scaffold(
        appBar: AppBar(
          title: Text('Temps de travail'),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15, top: 15, right: 15),
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                _DatePickerItem(
                  children: <Widget>[
                    const Text('Date'),
                    CupertinoButton(
                      // Display a CupertinoDatePicker in date picker mode.
                      onPressed: () => _showDialog(
                        CupertinoDatePicker(
                          minimumDate: DateTime.now(),
                          initialDateTime: DateTime.now(),
                          mode: CupertinoDatePickerMode.date,
                          // This is called when the user changes the date.
                          onDateTimeChanged: (DateTime newDate) {
                            print(newDate.toString());
                            setState(() => date = newDate);
                          },
                        ),
                      ),
                      // In this example, the date value is formatted manually. You can use intl package
                      // to format the value based on user's locale settings.
                      child: Text(
                        '${date.day}/${date.month}/${date.year}',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 2, // 20%
                        child: buildDatePickerTime(
                            'Debut matin', dateDebutMatin, (newDate) {
                          print(newDate);
                          setState(() => dateDebutMatin = newDate);
                        })),
                    Expanded(
                        flex: 2, // 20%
                        child: buildDatePickerTime('Fin matin', dateFinMatin,
                            (newDate) {
                          print(newDate);
                          setState(() => dateFinMatin = newDate);
                        })),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 2, // 20%
                        child: buildDatePickerTime('Debut soir', dateDebutSoir,
                            (newDate) {
                          print(newDate);
                          setState(() => dateDebutSoir = newDate);
                        })),
                    Expanded(
                        flex: 2, // 20%
                        child: buildDatePickerTime('Fin satin', dateFinSoir,
                            (newDate) {
                          print(newDate);
                          setState(() => dateFinSoir = newDate);
                        })),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(
                        40), // fromHeight use double.infinity as width and 40 is the height
                  ),
                  child: Text('Sauvegarder'),
                  onPressed: () {
                    saveHoraire();
                  },
                ),
                SizedBox(height: 20),
                ...widget.chantier.horaires.map((e) => Card(
                    elevation: 5,
                    child: Container(
                      child: ListTile(
                        leading: Icon(EvaIcons.clock),
                        title: Text(
                            getDyaName(e.weekday) + ' ' + e.date.split(' ')[0]),
                        subtitle: Text(buildHours(e)),
                      ),
                    )))
              ]),
            ),
          ),
        ));
  }

  _DatePickerItem buildDatePickerTime(
      String title, DateTime? dateTime, Function callBack) {
    return _DatePickerItem(
      children: <Widget>[
        Text(title),
        CupertinoButton(
          // Display a CupertinoDatePicker in date picker mode.
          onPressed: () => _showDialog(
            CupertinoDatePicker(
              initialDateTime: dateTime,
              mode: CupertinoDatePickerMode.time,
              // This is called when the user changes the date.
              onDateTimeChanged: (DateTime newDate) {
                print(newDate.toString());

                callBack(newDate);
              },
            ),
          ),
          // In this example, the date value is formatted manually. You can use intl package
          // to format the value based on user's locale settings.
          child: Text(
            '${dateTime?.hour}:${dateTime?.minute}',
          ),
        ),
      ],
    );
  }

  String buildHours(Horaire e) {
    return buildHour(e.debutMatin) +
        '-' +
        buildHour(e.finMatin) +
        '  ' +
        buildHour(e.debutSoir) +
        '-' +
        buildHour(e.finSoir);
  }

  String buildHour(String e) {
    DateTime date = DateTime.parse(e);
    return date.hour.toString() + ':' + date.minute.toString();
  }

  String getDyaName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Lundi';
      case 2:
        return 'Mardi';
      case 3:
        return 'Mercredi';
      case 4:
        return 'Jeudi ';
      case 5:
        return 'Vendredi';
      case 6:
        return 'Samedi ';
      case 7:
      default:
        return 'Dimanche';
    }
  }
}

// This class simply decorates a row of widgets.
class _DatePickerItem extends StatelessWidget {
  const _DatePickerItem({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0,
          ),
          bottom: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}
