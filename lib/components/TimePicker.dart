import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePicker extends StatefulWidget {
  late TimeOfDay? selectedTime;
  final void Function(TimeOfDay?)? onChanged;

  TimePicker({
    Key? key,
    this.selectedTime,
    this.onChanged,
  }) : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  NumberFormat numberFormat = new NumberFormat("00");
  //var selectedTime;

  @override
  void initState() {
    //selectedTime = widget.selectedTime!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        final newTime = await showTimePicker(
          context: context,
          initialTime: widget.selectedTime!,
          builder: (context, child) {
            return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child ?? Container(),
            );
          },
        );
        if (newTime != null) {
          setState(() {
            widget.selectedTime = newTime;
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
          '${numberFormat.format(widget.selectedTime!.hour).toString()}:${numberFormat.format(widget.selectedTime!.minute).toString()}'),
    );
  }
}
