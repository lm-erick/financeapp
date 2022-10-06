import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/controller/utils_controller.dart';
import 'package:finances/models/convenio_model.dart';
import 'package:finances/repositories/convenio_repository.dart';

class ConvenioController extends UtilsController {
  final ConvenioRepository repository = ConvenioRepository();

  void saveConvenio(String convenioId, Convenio convenio) {
    if (convenioId.isEmpty) {
      repository.saveConvenio(convenio);
    } else {
      repository.updateConvenio(convenioId, convenio);
    }
  }

  Future<bool> checkConvenioDocument(String document) async {
    return await repository
        .findByDocument(document)
        .then((QuerySnapshot querySnapshot) => querySnapshot.docs.isNotEmpty);
  }

  void deleteConvenio(String clientId) {
    repository.deleteConvenio(clientId);
  }

  Future<DocumentSnapshot<Object?>> getConvenio(String clientId) async {
    return await repository.findById(clientId);
  }

  Stream<QuerySnapshot<Object?>> getAllConvenio() {
    return repository.findAllConvenioSsnapshots();
  }

  Future<QuerySnapshot<Object?>> getAllClienteFuture() {
    return repository.findAllConveniosByList();
  }
}
