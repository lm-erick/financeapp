import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/controller/utils_controller.dart';
import 'package:finances/models/servico_model.dart';

class ServicoRepository extends UtilsController {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('servicos');

  void saveServico(Servico servico) {
    collection
        .add({
          'name': servico.name,
          'convenioId': servico.convenioId,
          'value': servico.value
        })
        .then((value) => {showToast('Inserido com sucesso')})
        .catchError((error) => {showToast("Falha ao inserir: $error")});
  }

  void updateServico(String servicoId, Servico servico) {
    collection
        .doc(servicoId)
        .update({
          'name': servico.name,
          'convenioId': servico.convenioId,
          'value': servico.value
        })
        .then((value) => {showToast('Atualizado com sucesso')})
        .catchError((error) => {showToast("Falha ao atualizar: $error")});
  }

  void deleteServico(String servicoId) {
    collection
        .doc(servicoId)
        .delete()
        .then((value) => {showToast("Deletado com sucesso")})
        .catchError((error) => {showToast("Falha ao deletar: $error")});
  }

  Future<DocumentSnapshot<Object?>> findById(String convenioId) {
    return collection.doc(convenioId).get();
  }

  Stream<QuerySnapshot<Object?>> findAllServicos() {
    return collection.snapshots();
  }

  Future<QuerySnapshot<Object?>> findByDocument(String document) {
    return collection.where('document', isEqualTo: document).get();
  }
}
