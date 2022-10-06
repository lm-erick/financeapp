import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/controller/funcionario_controller.dart';
import 'package:finances/models/funcionario_model.dart';
import 'package:finances/pages/create_text_form.dart';
import 'package:flutter/material.dart';

// Create a Form widget.
class CadastroFuncionarioPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _celphone = TextEditingController();
  final TextEditingController _document = TextEditingController();

  final FuncionarioController controller = FuncionarioController();

  final CreateTextForm utilsView = CreateTextForm();

  final String funcionarioId;

  CadastroFuncionarioPage(this.funcionarioId) {
    if (funcionarioId.isEmpty) return;

    controller
        .getFuncionario(funcionarioId)
        .then((DocumentSnapshot documentSnapshot) => {
              _name.text = documentSnapshot.get('name'),
              _email.text = documentSnapshot.get('email'),
              _phone.text = documentSnapshot.get('phone'),
              _celphone.text = documentSnapshot.get('celphone'),
              _document.text = documentSnapshot.get('document')
            });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Cadastro'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  utilsView.createTextFormFieldText(_name, 'Nome Completo'),
                  utilsView.createTextFormFieldEmail(_email, 'E-mail'),
                  utilsView.createTextFormFieldNumber(
                      _phone, 'Telefone', '(##) ####-####', 14),
                  utilsView.createTextFormFieldNumber(
                      _celphone, 'Celular', '(##) #####-####', 15),
                  utilsView.createTextFormFieldNumber(
                      _document, 'CPF', '###.###.###-##', 14),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;

                      if (funcionarioId.isEmpty &&
                          await controller.checkRegister(_document.text)) {
                        return controller
                            .showToast('Cliente já possui cadastro');
                      }

                      Funcionario funcionario = Funcionario(
                          name: _name.text,
                          email: _email.text,
                          celphone: _celphone.text,
                          document: _document.text,
                          phone: _phone.text);

                      controller.saveFuncionario(funcionarioId, funcionario);

                      Navigator.pop(context);
                    },
                    child: Text('Salvar'),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Voltar'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
