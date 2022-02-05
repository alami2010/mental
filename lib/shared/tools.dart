import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  static bool isNullEmpty(Object o) => o == null || "" == o;

  static bool isNullEmptyOrFalse(Object o) =>
      o == null || false == o || "" == o;

  static bool isNullEmptyFalseOrZero(Object o) =>
      o == null || false == o || 0 == o || "" == o;

  // _makingPhoneCall(number) async {
  //   bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  // }
//
  _whatsapp(number) async {
    await launch(
        "https://wa.me/$number?text=Hi, how are you?\n Can we meet sometimes?");
  }

  // _mail(eMail) async {
  //   final mailtoLink = Mailto(
  //       to: ["$eMail"],
  //       subject: "mail example",
  //       body: "Nice app but needs some improvement.");
  //   await launch("$mailtoLink");
  // }

  _instagram(username) async {
    await launch("https://www.instagram.com/$username/");
  }

  static Future<void> open(String url) async {
    print(url);
    if (await canLaunch(url))
      await launch(url);
    else
      // can't launch url, there is some error
      throw "Could not launch $url";
  }

  static void launchMap(String address) async {
    String query = Uri.encodeComponent(address);
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    }
  }

  static void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
