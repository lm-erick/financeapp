import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/controller/utils_controller.dart';
import 'package:finances/models/funcionario_model.dart';

class FuncionarioRepository extends UtilsController {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('funcionarios');

  void save(Funcionario funcionario) {
    collection
        .add({
          'document': funcionario.document,
          'email': funcionario.email,
          'celphone': funcionario.celphone,
          'name': funcionario.name,
          'phone': funcionario.phone
        })
        .then((value) => {showToast('Inserido com sucesso')})
        .catchError((error) => {showToast("Falha ao inserir: $error")});
  }

  void update(String funcionarioId, Funcionario funcionario) {
    collection
        .doc(funcionarioId)
        .update({
          'document': funcionario.document,
          'email': funcionario.email,
          'celphone': funcionario.celphone,
          'name': funcionario.name,
          'phone': funcionario.phone
        })
        .then((value) => {showToast('Atualizado com sucesso')})
        .catchError((error) => {showToast("Falha ao atualizar: $error")});
  }

  void delete(String funcionarioId) {
    collection
        .doc(funcionarioId)
        .delete()
        .then((value) => {showToast("Deletado com sucesso")})
        .catchError((error) => {showToast("Falha ao deletar: $error")});
  }

  Future<DocumentSnapshot<Object?>> findById(String funcionarioId) {
    return collection.doc(funcionarioId).get();
  }

  Stream<QuerySnapshot<Object?>> findAllFuncionarios() {
    return collection.snapshots();
  }

  Future<QuerySnapshot<Object?>> findByDocument(String document) {
    return collection.where('document', isEqualTo: document).get();
  }
}
