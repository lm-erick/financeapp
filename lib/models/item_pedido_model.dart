class ItemPedido {
  String desconto;
  String pedido_id;
  String quantidade;
  String servico_id;
  String valor_total;
  String nome_servico;

  ItemPedido(
      {required this.desconto,
      required this.pedido_id,
      required this.quantidade,
      required this.servico_id,
      required this.valor_total,
      required this.nome_servico});
}
