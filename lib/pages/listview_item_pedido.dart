import 'package:finances/controller/utils_controller.dart';
import 'package:finances/models/item_pedido_model.dart';
import 'package:flutter/material.dart';

class ListViewItemPedido extends StatefulWidget {
  ListViewItemPedido(
      {Key? key,
      required this.controllerServico,
      required this.controllerQuantidade,
      required this.controllerPrice,
      required this.controllerDesconto,
      required this.controllerNomeServico})
      : super(key: key);

  final TextEditingController controllerServico;
  final TextEditingController controllerQuantidade;
  final TextEditingController controllerPrice;
  final TextEditingController controllerDesconto;
  final TextEditingController controllerNomeServico;

  List<ItemPedido> items = <ItemPedido>[];

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
            if (widget.controllerServico.text.isEmpty)
              return UtilsController().showToast('Selecione um serviço');

            ItemPedido item = ItemPedido(
                desconto: widget.controllerDesconto.text,
                pedido_id: 'teste',
                quantidade: widget.controllerQuantidade.text,
                servico_id: widget.controllerServico.text,
                valor_total: widget.controllerPrice.text,
                nome_servico: widget.controllerNomeServico.text);
            stateSetter(item);
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
