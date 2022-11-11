import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputDatetime extends StatefulWidget {
  InputDatetime({
    Key? key,
    required this.dateTimeNow,
  }) : super(key: key);

  DateTime dateTimeNow;

  @override
  State<InputDatetime> createState() => InputDatetimeState();
}

class InputDatetimeState extends State<InputDatetime> {
  final formatDatetime = DateFormat('HH:mm dd/MM/yyyy');

  @override
  initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
      ),
      onPressed: () {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay(
              hour: widget.dateTimeNow.hour - 3,
              minute: widget.dateTimeNow.minute),
          initialEntryMode: TimePickerEntryMode.input,
        ).then((valueTime) {
          showDatePicker(
                  context: context,
                  initialDate: widget.dateTimeNow,
                  firstDate: DateTime(2001),
                  lastDate: DateTime(2030))
              .then((valueDate) {
            setState(() {
              widget.dateTimeNow = DateTime(valueDate!.year, valueDate.month,
                  valueDate.day, valueTime!.hour, valueTime.minute, 0, 0, 0);
            });
          }).catchError((onError) {
            print(onError);
          });
        }).catchError((onError) {
          print(onError);
        });
      },
      child: Text(formatDatetime.format(widget.dateTimeNow)),
    );
  }
}
