class ItemPacote {
  String servico_id;
  String valor_item;
  String name;
  ItemPacote(
      {required this.servico_id, required this.valor_item, required this.name});

  Map<String, dynamic> toJson() =>
      {'servico_id': servico_id, 'valor_item': valor_item, 'name': name};
}
