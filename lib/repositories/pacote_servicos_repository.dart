import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/controller/utils_controller.dart';
import 'package:finances/models/item_pacote.dart';
import 'package:finances/models/pacote_model.dart';

class PacoteRepository extends UtilsController {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('pacote_servicos');

  void save(PacoteServico pacote) {
    final itens = [];

    for (ItemPacote item in pacote.itens) {
      itens.add({
        'servico_id': item.servico_id,
        'valor_item': item.valor_item,
        'name': item.name
      });
    }

    final payload = {
      'name': pacote.name,
      'validade': pacote.validade,
      'itens': itens
    };

    collection
        .add(payload)
        .then((value) => {showToast('Inserido com sucesso')})
        .catchError((error) => {showToast("Falha ao inserir: $error")});
  }

  void delete(String pacoteId) {
    collection
        .doc(pacoteId)
        .delete()
        .then((value) => {showToast("Deletado com sucesso")})
        .catchError((error) => {showToast("Falha ao deletar: $error")});
  }

  Future<DocumentSnapshot<Object?>> findById(String pacoteId) {
    return collection.doc(pacoteId).get();
  }

  Stream<DocumentSnapshot<Object?>> findByIdStream(String pacoteId) {
    return collection.doc(pacoteId).snapshots();
  }

  Stream<QuerySnapshot<Object?>> findAll() {
    return collection.snapshots();
  }
}
