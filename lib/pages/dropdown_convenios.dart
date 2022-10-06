import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/controller/convenio_controller.dart';
import 'package:flutter/material.dart';

class DropdownButtonConvenios extends StatefulWidget {
  DropdownButtonConvenios({Key? key, required this.convenio}) : super(key: key);

  final TextEditingController convenio;

  @override
  State<DropdownButtonConvenios> createState() =>
      _DropdownButtonConveniosState();
}

class _DropdownButtonConveniosState extends State<DropdownButtonConvenios> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: ConvenioController().getAllConvenio(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text('Something went wrong');

        if (snapshot.connectionState == ConnectionState.waiting)
          return Text("Loading");

        if (widget.convenio.text.isEmpty) {
          widget.convenio.text = snapshot.data!.docs.first.id;
        }

        return DropdownButton<String>(
          value: widget.convenio.text,
          onChanged: (String? value) {
            setState(() {
              widget.convenio.text = value!;
            });
          },
          items: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return DropdownMenuItem<String>(
              value: document.id,
              child: Text(data['name']),
            );
          }).toList(),
        );
      },
    );
  }
}
