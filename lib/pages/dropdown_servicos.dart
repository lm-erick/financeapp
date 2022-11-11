import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/controller/servico_controller.dart';
import 'package:flutter/material.dart';

class DropdownButtonServicos extends StatefulWidget {
  DropdownButtonServicos({Key? key, required this.controller})
      : super(key: key);

  final TextEditingController controller;

  @override
  State<DropdownButtonServicos> createState() => _DropdownButtonFServicos();
}

class _DropdownButtonFServicos extends State<DropdownButtonServicos> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: ServicoController().getAllServico(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text('Something went wrong');

        if (snapshot.connectionState == ConnectionState.waiting)
          return Text("Loading");

        if (widget.controller.text.isEmpty) {
          widget.controller.text = snapshot.data!.docs.first.id;
        }

        return DropdownButton<String>(
          value: widget.controller.text,
          onChanged: (String? value) {
            setState(() {
              widget.controller.text = value!;
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
