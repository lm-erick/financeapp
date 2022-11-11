import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputDate extends StatefulWidget {
  InputDate({
    Key? key,
    required this.dateNow,
  }) : super(key: key);

  DateTime dateNow;

  @override
  State<InputDate> createState() => InputDateState();
}

class InputDateState extends State<InputDate> {
  final formatDatetime = DateFormat('dd/MM/yyyy');

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
        showDatePicker(
                context: context,
                initialDate: widget.dateNow,
                firstDate: DateTime(2001),
                lastDate: DateTime(2030))
            .then((valueDate) {
          setState(() {
            widget.dateNow = DateTime(
                valueDate!.year, valueDate.month, valueDate.day, 0, 0, 0, 0, 0);
          });
        }).catchError((onError) {
          print(onError);
        });
      },
      child: Text(formatDatetime.format(widget.dateNow)),
    );
  }
}
