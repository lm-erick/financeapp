import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/controller/cliente_controller.dart';
import 'package:finances/models/cliente_model.dart';
import 'package:finances/pages/create_text_form.dart';
import 'package:finances/pages/dropdown_convenios.dart';
import 'package:flutter/material.dart';

// Create a Form widget.
class CadastroClientePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _celphone = TextEditingController();
  final TextEditingController _document = TextEditingController();
  final TextEditingController _convenio = TextEditingController();

  final ClienteController controller = ClienteController();

  final CreateTextForm utilsView = CreateTextForm();

  final String clientId;

  CadastroClientePage(this.clientId) {
    if (clientId.isEmpty) return;

    controller
        .getCliente(clientId)
        .then((DocumentSnapshot documentSnapshot) => {
              _name.text = documentSnapshot.get('name'),
              _email.text = documentSnapshot.get('email'),
              _phone.text = documentSnapshot.get('phone'),
              _celphone.text = documentSnapshot.get('celphone'),
              _document.text = documentSnapshot.get('document'),
              _convenio.text = documentSnapshot.get('convenioId')
            });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text('Cadastro Cliente'),
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
                  utilsView.spaceBoxHeigth(10),
                  Text('Convênios'),
                  DropdownButtonConvenios(
                    convenio: _convenio,
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;

                      if (clientId.isEmpty &&
                          await controller
                              .checkClientDocument(_document.text)) {
                        return controller
                            .showToast('Cliente já possui cadastro');
                      }

                      Cliente cliente = Cliente(
                          name: _name.text,
                          email: _email.text,
                          celphone: _celphone.text,
                          document: _document.text,
                          phone: _phone.text,
                          convenioId: _convenio.text);

                      controller.saveClient(clientId, cliente);

                      Navigator.pop(context);
                    },
                    child: Text('Salvar'),
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
