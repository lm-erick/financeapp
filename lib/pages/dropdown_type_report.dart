import 'package:flutter/material.dart';

class DropdownButtonTypeReport extends StatefulWidget {
  DropdownButtonTypeReport({Key? key, required this.controller})
      : super(key: key);

  final TextEditingController controller;

  @override
  State<DropdownButtonTypeReport> createState() =>
      _DropdownButtonTypeReportState();
}

class _DropdownButtonTypeReportState extends State<DropdownButtonTypeReport> {
  List<String> types = ['Diário', 'Mensal', 'Anual'];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.controller.text.isNotEmpty
          ? widget.controller.text
          : types.first,
      onChanged: (String? value) {
        setState(() {
          widget.controller.text = value!;
        });
      },
      items: types.map((document) {
        return DropdownMenuItem<String>(
          value: document,
          child: Text(document),
        );
      }).toList(),
    );
  }
}
