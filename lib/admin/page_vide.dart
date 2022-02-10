import 'package:flutter/material.dart';

class PageEmpty extends StatefulWidget {
  const PageEmpty() : super();

  @override
  State<PageEmpty> createState() => _PageEmptyState();
}

class _PageEmptyState extends State<PageEmpty> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 4;

    return Scaffold(
        appBar: AppBar(
          title: Text('EN COURS'),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15, top: 15, right: 15),
          child: Column(children: <Widget>[Text('En cours')]),
        ));
  }

 }
