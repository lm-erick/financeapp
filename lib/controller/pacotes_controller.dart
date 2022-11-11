import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/controller/utils_controller.dart';
import 'package:finances/models/pacote_model.dart';
import 'package:finances/repositories/pacote_servicos_repository.dart';

class PacotesController extends UtilsController {
  final PacoteRepository repository = PacoteRepository();

  void save(PacoteServico pacote) {
    repository.save(pacote);
  }

  void delete(String pacoteId) {
    repository.delete(pacoteId);
  }

  Future<DocumentSnapshot<Object?>> get(String pacoteId) async {
    return await repository.findById(pacoteId);
  }

  Stream<QuerySnapshot<Object?>> getAll() {
    return repository.findAll();
  }
}
