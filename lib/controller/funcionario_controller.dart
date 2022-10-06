import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/controller/utils_controller.dart';
import 'package:finances/models/funcionario_model.dart';
import 'package:finances/repositories/funcionario_repository.dart';

class FuncionarioController extends UtilsController {
  final FuncionarioRepository repository = FuncionarioRepository();

  void saveFuncionario(String funcionarioId, Funcionario funcionario) {
    if (funcionarioId.isEmpty) {
      repository.save(funcionario);
    } else {
      repository.update(funcionarioId, funcionario);
    }
  }

  Future<bool> checkRegister(String document) async {
    return await repository
        .findByDocument(document)
        .then((QuerySnapshot querySnapshot) => querySnapshot.docs.isNotEmpty);
  }

  void deleteFuncionario(String funcionarioId) {
    repository.delete(funcionarioId);
  }

  Future<DocumentSnapshot<Object?>> getFuncionario(String funcionarioId) async {
    return await repository.findById(funcionarioId);
  }

  Stream<QuerySnapshot<Object?>> getAllFuncionarios() {
    return repository.findAllFuncionarios();
  }
}
