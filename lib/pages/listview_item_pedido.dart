import 'package:finances/controller/utils_controller.dart';
import 'package:finances/models/item_controller_model.dart';
import 'package:finances/models/item_pedido_model.dart';
import 'package:flutter/material.dart';

class ListViewItemPedido extends StatefulWidget {
  ListViewItemPedido({Key? key, required this.controllers, required this.items})
      : super(key: key);

  final ItemPedidoControllers controllers;

  List<ItemPedido> items;

  @override
  State<ListViewItemPedido> createState() => _ListViewItemPedidoState();
}

class _ListViewItemPedidoState extends State<ListViewItemPedido> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: TextButton.styleFrom(
            primary: Colors.white,
          ),
          onPressed: () {
            if (widget.controllers.servico.text.isEmpty)
              return UtilsController().showToast('Selecione um serviço');

            ItemPedido itemPedido = ItemPedido(
                desconto: widget.controllers.desconto.text,
                quantidade: widget.controllers.quantidade.text,
                servico_id: widget.controllers.servico.text,
                valor_total: widget.controllers.price.text,
                nome_servico: widget.controllers.nomeServico.text);

            stateSetter(itemPedido);
          },
          child: Text('Adicionar Item'),
        ),
        ListView(
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: widget.items.map((item) {
            double finalPrice =
                double.parse(item.valor_total.replaceAll(',', '.'));

            finalPrice = finalPrice * double.parse(item.quantidade);

            double discount = (double.parse(item.desconto) / 100) * finalPrice;

            finalPrice = finalPrice - discount;

            String finalPriceConvert = UtilsController()
                .moneyFormater()
                .format(finalPrice.toStringAsFixed(2).toString())
                .toString();

            String quantidade = item.quantidade;

            String discountText = item.desconto;

            String priceUnd = item.valor_total;

            String infos =
                "VUND: R\$ $priceUnd QTD: $quantidade \nDESC: $discountText% VT: R\$ $finalPriceConvert ";

            print(infos);

            return ListTile(
                title: Text(item.nome_servico),
                subtitle: Text(infos),
                trailing: options(context, item.servico_id));
          }).toList(),
        )
      ],
    );
  }

  void stateSetter(ItemPedido item) {
    setState(() {
      widget.items.add(item);
    });
  }

  void stateRemove(index) {
    setState(() {
      widget.items.removeAt(index);
    });
  }

  Widget options(BuildContext context, String servicoId) {
    return IconButton(
        iconSize: 20.0,
        icon: Icon(Icons.restore_from_trash_rounded),
        tooltip: 'Editar',
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Confirme"),
                content: Text("Deseja realmente deletar?"),
                actions: [
                  TextButton(
                      child: Text("Não"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  TextButton(
                      child: Text("Sim"),
                      onPressed: () {
                        final index = widget.items.indexWhere(
                            (element) => element.servico_id == servicoId);

                        stateRemove(index);
                        Navigator.of(context).pop();
                      })
                ],
              );
            },
          );
        });
  }
}
