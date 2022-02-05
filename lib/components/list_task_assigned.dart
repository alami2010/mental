import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class ListMenuData {
  final Icon icon;
  final String label;
  final Widget page;
  final bool? alert;
  final bool? showTrailing;
  final Function? notifyParent;

  const ListMenuData({
    required this.icon,
    required this.label,
    required this.page,
    this.alert,
    this.showTrailing,
    this.notifyParent,
  });
}

class ListMenu extends StatelessWidget {
  const ListMenu({
    required this.data,
    Key? key,
  }) : super(key: key);

  final ListMenuData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
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
          leading: _buildIcon(data.icon),
          title: _buildTitle(),
          trailing: getTrailing()),
    );
  }

  Widget? getTrailing() {
    return data.showTrailing == true
        ? data.alert == false
            ? _buildIcon(const Icon(
                EvaIcons.alertTriangle,
                color: Colors.orange,
              ))
            : _buildIcon(const Icon(
                EvaIcons.doneAll,
                color: Colors.green,
              ))
        : null;
  }

  Widget _buildIcon(Icon icon) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueGrey.withOpacity(.1),
      ),
      child: icon,
    );
  }

  Widget _buildTitle() {
    return Text(
      data.label,
      style: const TextStyle(fontWeight: FontWeight.bold),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
