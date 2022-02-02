import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/data.dart';

class Tools {
  static Expanded getListViewData(List<Data> dataListView) {
    return Expanded(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: 200.0,
        ),
        child: ListView.builder(
            itemCount: dataListView.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 40,
                margin: EdgeInsets.all(2),
                color: Colors.blue.withOpacity(0.4),
                child: Center(child: Text('${dataListView[index].name}')),
              );
            }),
      ),
    );
  }

  static Expanded getListViewFiles(List<PlatformFile> dataListView) {
    return Expanded(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: 200.0,
        ),
        child: ListView.builder(
            itemCount: dataListView.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 40,
                margin: EdgeInsets.all(2),
                color: Colors.blue.withOpacity(0.4),
                child: Center(child: Text('${dataListView[index].name}')),
              );
            }),
      ),
    );
  }

  static getListViewString(List<String> data) {
    return Expanded(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: 200.0,
        ),
        child: ListView.builder(
             itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 40,
                margin: EdgeInsets.all(2),
                color: Colors.blue.withOpacity(0.4),
                child: Center(child: Text('${data[index]}')),
              );
            }),
      ),
    );
  }


  static bool isNullEmpty(Object o) =>
      o == null ||  "" == o;

  static bool isNullEmptyOrFalse(Object o) =>
      o == null || false == o || "" == o;

  static bool isNullEmptyFalseOrZero(Object o) =>
      o == null || false == o || 0 == o || "" == o;
}
