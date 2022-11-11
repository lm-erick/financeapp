import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/controller/pacotes_controller.dart';
import 'package:finances/controller/servico_controller.dart';
import 'package:finances/models/item_pacote.dart';
import 'package:finances/models/pacote_model.dart';
import 'package:finances/pages/create_text_form.dart';
import 'package:finances/pages/input_datetime.dart';
import 'package:finances/pages/listview_item_pacote.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Create a Form widget.
class CadastroPacoteServicos extends StatelessWidget {
  final String pacoteId;

  CadastroPacoteServicos(this.pacoteId) {
    if (pacoteId.isEmpty) return;

    controller.get(pacoteId).then((DocumentSnapshot documentSnapshot) => {
          _name.text = documentSnapshot.get('name'),
          dateTimeNow = DateTime.parse(
              documentSnapshot.get('validade').toDate().toString()),
          for (final item in documentSnapshot.get('itens'))
            {
              items.add(ItemPacote(
                  servico_id: item['servico_id'],
                  valor_item: item['valor_item'],
                  name: item['name'])),
            }
        });
  }

  final _formKey = GlobalKey<FormState>();

  String itensToString = '';

  TextEditingController _name = TextEditingController();
  TextEditingController _servico = TextEditingController();
  TextEditingController _nomeServico = TextEditingController();
  TextEditingController _price = TextEditingController();

  final PacotesController controller = PacotesController();

  final CreateTextForm utilsView = CreateTextForm();

  DateTime dateTimeNow = DateTime.now().toLocal();

  List<ItemPacote> items = <ItemPacote>[];

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
          title: Text('Cadastro pacote de serviços'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  utilsView.createTextFormFieldText(_name, 'Nome Pacote'),
                  spaceBoxHeigth(10),
                  Text('Validade'),
                  InputDatetime(dateTimeNow: dateTimeNow),
                  spaceBoxHeigth(10),
                  inputServices(_price, _servico, _nomeServico),
                  utilsView.createTextFormFieldText(_nomeServico, 'Serviço'),
                  TextFormField(
                    controller: _price,
                    decoration: InputDecoration(labelText: 'Preço'),
                    inputFormatters: <TextInputFormatter>[
                      controller.moneyFormater()
                    ],
                    keyboardType: TextInputType.number,
                  ),
                  ListViewItemPacote(
                    controllerServico: _servico,
                    controllerNomeServico: _nomeServico,
                    controllerPrice: _price,
                    items: items,
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;

                      if (items.isEmpty) {
                        controller
                            .showToast('Por favor insira os itens do pacote');
                        return;
                      }

                      PacoteServico pacote = PacoteServico(
                          name: _name.text,
                          itens: items,
                          validade: dateTimeNow);

                      controller.save(pacote);

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

  Widget inputServices(TextEditingController price,
      TextEditingController servico, TextEditingController nomeServico) {
    return StreamBuilder<QuerySnapshot>(
      stream: ServicoController().getAllServico(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text('Something went wrong');

        if (snapshot.connectionState == ConnectionState.waiting)
          return Text("Loading");

        return Wrap(
            runSpacing: 5.0,
            spacing: 5.0,
            alignment: WrapAlignment.center,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              return SizedBox(
                  width: 85,
                  height: 50,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: () {
                      servico.text = document.id;
                      nomeServico.text = data['name'];
                      price.text = controller
                          .moneyFormater()
                          .format(data['value'].toStringAsFixed(2).toString())
                          .toString();
                    },
                    child: Text(data['name'],
                        style: TextStyle(height: 1, fontSize: 10)),
                  ));
            }).toList());
      },
    );
  }

  SizedBox spaceBoxWidth(double value) {
    return SizedBox(width: value);
  }

  SizedBox spaceBoxHeigth(double value) {
    return SizedBox(height: value);
  }
}
