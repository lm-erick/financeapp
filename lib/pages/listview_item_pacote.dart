import 'dart:async';

import 'package:finances/controller/utils_controller.dart';
import 'package:finances/models/item_pacote.dart';
import 'package:flutter/material.dart';

class ListViewItemPacote extends StatefulWidget {
  ListViewItemPacote(
      {Key? key,
      required this.controllerServico,
      required this.controllerPrice,
      required this.controllerNomeServico,
      required this.items})
      : super(key: key);

  final TextEditingController controllerServico;
  final TextEditingController controllerPrice;
  final TextEditingController controllerNomeServico;

  List<ItemPacote> items;

  @override
  State<ListViewItemPacote> createState() => _ListViewItemPacoteState();
}

class _ListViewItemPacoteState extends State<ListViewItemPacote> {
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

            ItemPacote item = ItemPacote(
                servico_id: widget.controllerServico.text,
                valor_item: widget.controllerPrice.text,
                name: widget.controllerNomeServico.text);
            stateSetter(item);
          },
          child: Text('Adicionar Item'),
        ),
        ListView(
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: widget.items.map((item) {
            return ListTile(
                title: Text(item.name),
                subtitle: Text(item.valor_item),
                trailing: options(context, item.servico_id));
          }).toList(),
        )
      ],
    );
  }

  void stateSetter(ItemPacote item) {
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
