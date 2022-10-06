import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/controller/utils_controller.dart';
import 'package:finances/models/cliente_model.dart';

class ClienteRepository extends UtilsController {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('clientes');

  void saveClient(Cliente cliente) {
    collection
        .add({
          'document': cliente.document,
          'email': cliente.email,
          'celphone': cliente.celphone,
          'name': cliente.name,
          'phone': cliente.phone,
          'convenioId': cliente.convenioId
        })
        .then((value) => {showToast('Inserido com sucesso')})
        .catchError((error) => {showToast("Falha ao inserir: $error")});
  }

  void updateClient(String clientId, Cliente cliente) {
    collection
        .doc(clientId)
        .update({
          'document': cliente.document,
          'email': cliente.email,
          'celphone': cliente.celphone,
          'name': cliente.name,
          'phone': cliente.phone,
          'convenioId': cliente.convenioId
        })
        .then((value) => {showToast('Atualizado com sucesso')})
        .catchError((error) => {showToast("Falha ao atualizar: $error")});
  }

  void deleteClient(String clientId) {
    collection
        .doc(clientId)
        .delete()
        .then((value) => {showToast("Deletado com sucesso")})
        .catchError((error) => {showToast("Falha ao deletar: $error")});
  }

  Future<DocumentSnapshot<Object?>> findById(String clientId) {
    return collection.doc(clientId).get();
  }

  Stream<QuerySnapshot<Object?>> findAllClients() {
    return collection.snapshots();
  }

  Future<QuerySnapshot<Object?>> findByDocument(String document) {
    return collection.where('document', isEqualTo: document).get();
  }
}
