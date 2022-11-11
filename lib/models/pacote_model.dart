import 'package:finances/models/item_pacote.dart';

class PacoteServico {
  String name;
  DateTime validade;
  List<ItemPacote> itens;
  PacoteServico(
      {required this.name, required this.validade, required this.itens});
}
