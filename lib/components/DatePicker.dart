import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Reserva.dart';

class DatePicker extends StatefulWidget {
  final DateTime? selectedDate;

  DatePicker({
    Key? key,
    this.selectedDate,
  }) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  NumberFormat numberFormat = new NumberFormat("00");
  var selectedDate;

  @override
  void initState() {
    selectedDate = widget.selectedDate;
    super.initState();
  }

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
