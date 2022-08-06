import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePicker extends StatefulWidget {
  final ValueChanged<TimeOfDay> onTimeChanged;

  TimePicker({
    Key? key,
    required this.onTimeChanged,
  }) : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay selectedTime = TimeOfDay(hour: 0, minute: 0);
  NumberFormat numberFormat = new NumberFormat("00");

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        final newTime = await showTimePicker(
          context: context,
          initialTime: selectedTime,
          builder: (context, child) {
            return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child ?? Container(),
            );
          },
        );
        if (newTime != null) {
          widget.onTimeChanged(newTime);
          setState(() {
            selectedTime = newTime;
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
          '${numberFormat.format(selectedTime.hour).toString()}:${numberFormat.format(selectedTime.minute).toString()}'),
    );
  }
}
