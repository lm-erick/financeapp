import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/controller/convenio_controller.dart';
import 'package:finances/models/convenio_model.dart';
import 'package:finances/pages/create_text_form.dart';
import 'package:flutter/material.dart';

// Create a Form widget.
class CadastroConvenioPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _cnpj = TextEditingController();

  final ConvenioController controller = ConvenioController();

  final CreateTextForm utilsView = CreateTextForm();

  final String convenioId;

  CadastroConvenioPage(this.convenioId) {
    if (convenioId.isEmpty) return;

    controller
        .getConvenio(convenioId)
        .then((DocumentSnapshot documentSnapshot) => {
              _name.text = documentSnapshot.get('name'),
              _cnpj.text = documentSnapshot.get('cnpj'),
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
                  utilsView.createTextFormFieldNumber(
                      _cnpj, 'Cnpj', '##.###.###/####-##', 18),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;

                      if (convenioId.isEmpty &&
                          await controller.checkConvenioDocument(_cnpj.text)) {
                        return controller
                            .showToast('Convenio já possui cadastro');
                      }

                      Convenio convenio =
                          Convenio(name: _name.text, cnpj: _cnpj.text);

                      controller.saveConvenio(convenioId, convenio);

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
