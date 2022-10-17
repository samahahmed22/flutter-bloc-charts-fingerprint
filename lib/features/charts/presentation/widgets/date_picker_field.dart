import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatefulWidget {
  String label;
  final void Function(DateTime? pickedDate) pickDate;

  DatePickerField(this.label, this.pickDate);

  @override
  _DatePickerFieldState createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  TextEditingController dateController = TextEditingController();
  DateTime lastPickedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    dateController.text = "";
  }

  Future pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: lastPickedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      lastPickedDate = pickedDate;
      String formattedDate = DateFormat("yyyy-MM-dd").format(lastPickedDate);

      setState(() {
        dateController.text = formattedDate.toString();
      });
    }

    widget.pickDate(pickedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Center(
            child: TextFormField(
                controller: dateController,
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today), labelText: widget.label),
                readOnly: true,
                onTap: () async {
                  pickDate();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    widget.pickDate;
                    return 'This field can\'t be empty!';
                  }
                })));
  }
}
