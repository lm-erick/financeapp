import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/controller/servico_controller.dart';
import 'package:finances/models/servico_model.dart';
import 'package:finances/pages/create_text_form.dart';
import 'package:finances/pages/dropdown_convenios.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Create a Form widget.
class CadastroServico extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _name = TextEditingController();
  TextEditingController _convenio = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _duracao = TextEditingController();

  final ServicoController controller = ServicoController();

  final CreateTextForm utilsView = CreateTextForm();

  final String servicoId;

  CadastroServico(this.servicoId) {
    if (servicoId.isEmpty) return;

    controller
        .getServico(servicoId)
        .then((DocumentSnapshot documentSnapshot) => {
              _name.text = documentSnapshot.get('name'),
              _convenio.text = documentSnapshot.get('convenioId'),
              _price.text = controller.moneyFormater().format(
                  documentSnapshot.get('value').toStringAsFixed(2).toString()),
              _duracao.text = documentSnapshot.get('duration').toString()
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
          title: Text('Cadastro Serviço'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  utilsView.createTextFormFieldText(_name, 'Nome Serviço'),
                  TextFormField(
                    controller: _price,
                    decoration: InputDecoration(labelText: 'Preço'),
                    inputFormatters: <TextInputFormatter>[
                      controller.moneyFormater()
                    ],
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: _duracao,
                    decoration: InputDecoration(labelText: 'Duração (Minutos)'),
                    keyboardType: TextInputType.number,
                  ),
                  utilsView.spaceBoxHeigth(10),
                  Text('Convênio'),
                  DropdownButtonConvenios(
                    convenio: _convenio,
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;

                      Servico servico = Servico(
                          name: _name.text,
                          value: num.parse(_price.text.replaceAll(',', '.')),
                          convenioId: _convenio.text,
                          duration:
                              num.parse(_duracao.text.replaceAll(',', '.')));

                      controller.saveServico(servicoId, servico);

                      Navigator.pop(context);
                    },
                    child: Text('Salvar'),
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
