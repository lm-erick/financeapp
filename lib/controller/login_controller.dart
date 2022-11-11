import 'package:finances/controller/utils_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends UtilsController {
  final String USER_ERROR = 'Usuário ou senha inválido';

  Future signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      showToast(USER_ERROR);
    }
  }

  Future signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      showToast(e.code);
    }
  }
}
