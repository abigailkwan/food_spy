import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'services.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';


class dateTimePicker extends StatefulWidget {
  final _dateTimeController;

  dateTimePicker(this._dateTimeController);

  @override
  BasicDateTimeField createState() => BasicDateTimeField(_dateTimeController);
}

class BasicDateTimeField extends State<dateTimePicker> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final _dateTimeController;
  DateTime date;
  TimeOfDay time;

  BasicDateTimeField(this._dateTimeController);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
        Text('Basic date & time field (${format.pattern})'),
        DateTimeField(
        decoration: InputDecoration(
          labelText: 'Expiration Date',
          border: OutlineInputBorder(),
        ),
        onChanged: (dt) => setState(() => date = dt),
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
              TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            setState(() {_dateTimeController.text = DateTimeField.combine(date,time).toString();});
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    ])
    );
  }
}


