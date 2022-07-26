import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Reserva.dart';

class DatePicker extends StatefulWidget {
  final String? selectedDate;

  DatePicker({
    Key? key,
    this.selectedDate,
  }) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  NumberFormat numberFormat = new NumberFormat("00");
  //DateTime? selectedDate;
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        final newDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 1),
          builder: (context, child) {
            return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child ?? Container(),
            );
          },
        );
        if (newDate != null) {
          setState(() {
            date = newDate;
          });
        }
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        )),
      ),
      child: Text(
          '${numberFormat.format(date.day).toString()}/${numberFormat.format(date.month).toString()}/${numberFormat.format(date.year).toString()}'),
    );
  }
}
