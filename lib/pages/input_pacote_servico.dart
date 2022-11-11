import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/controller/pacotes_controller.dart';
import 'package:finances/models/item_controller_model.dart';
import 'package:finances/models/item_pedido_model.dart';
import 'package:finances/pages/create_text_form.dart';
import 'package:finances/pages/input_servico.dart';
import 'package:flutter/material.dart';

class InputPacotes extends StatefulWidget {
  InputPacotes({Key? key, required this.orderItens, required this.controllers})
      : super(key: key);

  final List<ItemPedido> orderItens;

  final ItemPedidoControllers controllers;

  @override
  State<InputPacotes> createState() => _InputPacotesState();
}

class _InputPacotesState extends State<InputPacotes> {
  final CreateTextForm utilsView = CreateTextForm();
  final PacotesController controller = PacotesController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Selecione um pacote'),
        utilsView.spaceBoxHeigth(10),
        streamPacotes(),
        utilsView.spaceBoxHeigth(10),
        Text('Selecione um serviço'),
        utilsView.spaceBoxHeigth(10),
        InputServico(widget.orderItens).getInput(widget.controllers)
      ],
    );
  }

  Widget streamPacotes() {
    return StreamBuilder<QuerySnapshot>(
      stream: controller.getAll(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text('Something went wrong');

        if (snapshot.connectionState == ConnectionState.waiting)
          return Text("Loading");

        return Wrap(
          runSpacing: 5.0,
          spacing: 5.0,
          alignment: WrapAlignment.center,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;

            return SizedBox(
                width: 85,
                height: 50,
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    widget.orderItens.clear();

                    for (final item in data['itens']) {
                      ItemPedido itemPedido = ItemPedido(
                          desconto: '0',
                          quantidade: '1',
                          servico_id: item['servico_id'],
                          valor_total: item['valor_item'],
                          nome_servico: item['name']);
                      stateSetter(itemPedido);
                    }
                  },
                  child: Text(data['name'],
                      style: TextStyle(height: 1, fontSize: 10)),
                ));
          }).toList(),
        );
      },
    );
  }

  void stateSetter(ItemPedido item) {
    setState(() {
      widget.orderItens.add(item);
    });
  }
}
