import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Reserva.dart';

class DatePicker extends StatefulWidget {
  final ValueChanged<DateTime> onDateChanged;

  DatePicker({
    Key? key,
    required this.onDateChanged,
  }) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime selectedDate = DateTime.now();
  NumberFormat numberFormat = new NumberFormat("00");

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        final newDate = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 1),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                primary: Color(0xFFB497F2),
              )),
              child: MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: true),
                child: child ?? Container(),
              ),
            );
          },
        );
        if (newDate != null) {
          widget.onDateChanged(newDate);
          setState(() {
            selectedDate = newDate;
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
          '${numberFormat.format(selectedDate.day).toString()}/${numberFormat.format(selectedDate.month).toString()}/${numberFormat.format(selectedDate.year).toString()}'),
    );
  }
}
