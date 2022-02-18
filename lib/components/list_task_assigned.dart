import 'package:flutter/material.dart';

class ListMenuData {
  final Icon icon;
  final String label;
  final Widget page;
  final Color color;
  final bool? alert;
  final bool? showTrailing;
  final Function? notifyParent;

  const ListMenuData({
    required this.icon,
    required this.label,
    required this.page,
    required this.color,
    this.alert,
    this.showTrailing,
    this.notifyParent,
  });
}

class CardMenu extends StatelessWidget {
  const CardMenu({
    required this.data,
    Key? key,
  }) : super(key: key);

  final ListMenuData data;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.all(2),
        child: Card(
          child: SizedBox(
              height: size.height * .1,
              width: size.width * .80,
              child: Center(
                  child: ListTile(
                onTap: () => {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => data.page))
                      .then((value) {
                    if (data.notifyParent != null) {
                      data.notifyParent!();
                    }
                  })
                },
                leading: CircleAvatar(
                  backgroundColor: data.color,
                  child: data.icon,
                ),
                title: Text(
                  data.label,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ))),
        ));
  }
}
