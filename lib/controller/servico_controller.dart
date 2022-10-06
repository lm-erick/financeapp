import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/controller/utils_controller.dart';
import 'package:finances/models/servico_model.dart';
import 'package:finances/repositories/servico_repository.dart';

class ServicoController extends UtilsController {
  final ServicoRepository repository = ServicoRepository();

  void saveServico(String servicoId, Servico servico) {
    if (servicoId.isEmpty) {
      repository.saveServico(servico);
    } else {
      repository.updateServico(servicoId, servico);
    }
  }

  Future<bool> checkServicoDocument(String document) async {
    return await repository
        .findByDocument(document)
        .then((QuerySnapshot querySnapshot) => querySnapshot.docs.isNotEmpty);
  }

  void deleteServico(String servicoId) {
    repository.deleteServico(servicoId);
  }

  Future<DocumentSnapshot<Object?>> getServico(String servicoId) async {
    return await repository.findById(servicoId);
  }

  Stream<QuerySnapshot<Object?>> getAllServico() {
    return repository.findAllServicos();
  }
}
