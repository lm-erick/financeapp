import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/controller/servico_controller.dart';
import 'package:finances/models/item_controller_model.dart';
import 'package:finances/models/item_pedido_model.dart';
import 'package:finances/pages/create_text_form.dart';
import 'package:finances/pages/listview_item_pedido.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputServico {
  InputServico(List<ItemPedido> itens) {
    orderItens = itens;
  }

  final CreateTextForm utilsView = CreateTextForm();
  final ServicoController controller = ServicoController();

  List<ItemPedido> orderItens = <ItemPedido>[];

  Widget getInput(ItemPedidoControllers controllers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        inputServices(
            controllers.price, controllers.servico, controllers.nomeServico),
        utilsView.createTextFormFieldText(controllers.nomeServico, 'Serviço'),
        TextFormField(
          controller: controllers.price,
          decoration: InputDecoration(labelText: 'Preço'),
          inputFormatters: <TextInputFormatter>[controller.moneyFormater()],
          keyboardType: TextInputType.number,
        ),
        utilsView.createTextFormFieldNumber(
            controllers.quantidade, 'Quantidade', '########', 14),
        utilsView.createTextFormFieldNumber(
            controllers.desconto, 'Desconto (%)', '########', 14),
        ListViewItemPedido(controllers: controllers, items: orderItens),
        utilsView.spaceBoxHeigth(75),
      ],
    );
  }

  Widget inputServices(TextEditingController price,
      TextEditingController servico, TextEditingController nomeServico) {
    return StreamBuilder<QuerySnapshot>(
      stream: controller.getAllServico(),
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
                      servico.text = document.id;
                      nomeServico.text = data['name'];
                      price.text = controller
                          .moneyFormater()
                          .format(data['value'].toStringAsFixed(2).toString())
                          .toString();
                    },
                    child: Text(data['name'],
                        style: TextStyle(height: 1, fontSize: 10)),
                  ));
            }).toList());
      },
    );
  }
}
