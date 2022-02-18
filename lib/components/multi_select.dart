// Multi Select widget
// This widget is reusable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/data.dart';

class MultiSelect extends StatefulWidget {
  final List<Data> items;
  final List<Data> selectedItems;
  String title = "";

  MultiSelect(
      {Key? key,
      required this.items,
      required this.selectedItems,
      required this.title})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(Data itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        widget.selectedItems.add(itemValue);
      } else {
        widget.selectedItems.remove(itemValue);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, widget.selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    value: widget.selectedItems.contains(item),
                    title: Text(item.name),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Sortir'),
          onPressed: _cancel,
        ),
        ElevatedButton(
          child: const Text('Valider'),
          onPressed: _submit,
        ),
      ],
    );
  }
}
