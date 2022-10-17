import 'package:flutter/material.dart';

class DropDownField extends StatefulWidget {
  String label;
  Map<String, String> menuItems;
  final void Function(String? selectedItem) selectItem;
  DropDownField(this.label, this.menuItems, this.selectItem);

  @override
  State<DropDownField> createState() => _DropDownFieldState();
}

class _DropDownFieldState extends State<DropDownField> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    selectedItem = selectedItem ?? widget.menuItems.keys.first;
    return Container(
        padding: const EdgeInsets.all(20),
        child: DropdownButtonFormField<String?>(
          value: selectedItem,
          items: widget.menuItems.keys
              .toList()
              .map(
                (e) => DropdownMenuItem(
                  child: Text(
                    widget.menuItems[e] ?? '',
                  ),
                  value: e,
                ),
              )
              .toList(),
          onChanged: (val) {
            setState(() {
              selectedItem = val as String;
              widget.selectItem(selectedItem);
            });
          },
          icon: const Icon(Icons.arrow_drop_down_circle),
          decoration: InputDecoration(labelText: widget.label),
        ));
  }
}
