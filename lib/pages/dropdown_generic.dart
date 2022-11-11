import 'package:flutter/material.dart';

class DropdownButtonGeneric extends StatefulWidget {
  DropdownButtonGeneric(
      {Key? key,
      required this.controller,
      required this.itens,
      required this.option})
      : super(key: key);

  final TextEditingController controller;
  final List<String> itens;
  String option;

  @override
  State<DropdownButtonGeneric> createState() => _DropdownButtonGenericState();
}

class _DropdownButtonGenericState extends State<DropdownButtonGeneric> {
  @override
  Widget build(BuildContext context) {
    if (widget.controller.text.isEmpty) {
      widget.controller.text = widget.itens.first;
    }

    return DropdownButton<String>(
      value: widget.controller.text,
      onChanged: (String? value) {
        setState(() {
          widget.controller.text = value!;
        });
      },
      items: widget.itens.map<DropdownMenuItem<String>>((String document) {
        return DropdownMenuItem<String>(
          value: document,
          child: Text(document),
        );
      }).toList(),
    );
  }
}
