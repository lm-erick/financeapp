import 'package:flutter/material.dart';

class ItemPedidoControllers {
  ItemPedidoControllers({
    required this.servico,
    required this.nomeServico,
    required this.quantidade,
    required this.price,
    required this.desconto,
  });

  final TextEditingController servico;
  final TextEditingController nomeServico;
  final TextEditingController quantidade;
  final TextEditingController price;
  final TextEditingController desconto;
}
