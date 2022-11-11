import 'package:finances/models/item_pedido_model.dart';

class Order {
  String clienteId;
  String orderType;
  List<ItemPedido> orderItens;

  Order(
      {required this.clienteId,
      required this.orderType,
      required this.orderItens});
}
