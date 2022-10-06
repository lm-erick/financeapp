import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/controller/utils_controller.dart';
import 'package:finances/models/cliente_model.dart';
import 'package:finances/repositories/cliente_repository.dart';

class ClienteController extends UtilsController {
  final ClienteRepository repository = ClienteRepository();

  void saveClient(String clienteId, Cliente cliente) {
    if (clienteId.isEmpty) {
      repository.saveClient(cliente);
    } else {
      repository.updateClient(clienteId, cliente);
    }
  }

  Future<bool> checkClientDocument(String document) async {
    return await repository
        .findByDocument(document)
        .then((QuerySnapshot querySnapshot) => querySnapshot.docs.isNotEmpty);
  }

  void deleteClient(String clientId) {
    repository.deleteClient(clientId);
  }

  Future<DocumentSnapshot<Object?>> getCliente(String clientId) async {
    return await repository.findById(clientId);
  }

  Stream<QuerySnapshot<Object?>> getAllClients() {
    return repository.findAllClients();
  }
}
