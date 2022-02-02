import 'package:flutter/material.dart';
import 'package:mental/constants/app_constants.dart';

class ListTaskAssignedData {
  final Icon icon;
  final String label;
  final Widget page;
  final DateTime? editDate;
  final String? assignTo;

  const ListTaskAssignedData({
    required this.icon,
    required this.label,
    required this.page,
    this.editDate,
    this.assignTo,
  });
}

class ListTaskAssigned extends StatelessWidget {
  const ListTaskAssigned({
    required this.data,
    Key? key,
  }) : super(key: key);

  final ListTaskAssignedData data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => data.page))
      },
      hoverColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      leading: _buildIcon(),
      title: _buildTitle(),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueGrey.withOpacity(.1),
      ),
      child: data.icon,
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
