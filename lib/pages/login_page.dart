import 'package:finances/controller/login_controller.dart';
import 'package:finances/pages/create_text_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _login = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final LoginController controller = LoginController();
  final CreateTextForm utilsView = CreateTextForm();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Barbearia do Zé'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  utilsView.createTextFormFieldEmail(_login, 'Login'),
                  utilsView.createTextFormFieldPassword(_password, 'Senha'),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;

                      controller.signIn(_login.text, _password.text);
                    },
                    child: Text('Entrar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
