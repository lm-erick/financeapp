import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/controller/utils_controller.dart';
import 'package:finances/models/convenio_model.dart';

class ConvenioRepository extends UtilsController {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('convenios');

  void saveConvenio(Convenio convenio) {
    collection
        .add({'name': convenio.name, 'cnpj': convenio.cnpj})
        .then((value) => {showToast('Inserido com sucesso')})
        .catchError((error) => {showToast("Falha ao inseir: $error")});
  }

  void updateConvenio(String convenioId, Convenio convenio) {
    collection
        .doc(convenioId)
        .update({'name': convenio.name, 'cnpj': convenio.cnpj})
        .then((value) => {showToast('Atualizado com sucesso')})
        .catchError((error) => {showToast("Falha ao atualizar: $error")});
  }

  void deleteConvenio(String convenioId) {
    collection
        .doc(convenioId)
        .delete()
        .then((value) => {showToast("Deletado com sucesso")})
        .catchError((error) => {showToast("Falha ao deletar: $error")});
  }

  Future<DocumentSnapshot<Object?>> findById(String convenioId) {
    return collection.doc(convenioId).get();
  }

  Stream<QuerySnapshot<Object?>> findAllConvenioSsnapshots() {
    return collection.snapshots();
  }

  Future<QuerySnapshot<Object?>> findAllConveniosByList() {
    return collection.get();
  }

  Future<QuerySnapshot<Object?>> findByDocument(String document) {
    return collection.where('document', isEqualTo: document).get();
  }
}
