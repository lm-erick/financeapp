import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/controller/caixa_controller.dart';
import 'package:finances/controller/servico_controller.dart';
import 'package:finances/pages/create_text_form.dart';
import 'package:finances/pages/dropdown_clientes.dart';
import 'package:finances/pages/listview_item_pedido.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Create a Form widget.
class CaixaPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  CaixaController controller = CaixaController();

  TextEditingController _convenio = TextEditingController();
  TextEditingController _servico = TextEditingController();
  TextEditingController _nomeServico = TextEditingController();
  TextEditingController _cliente = TextEditingController();
  TextEditingController _quantidade = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _desconto = TextEditingController();

  final CreateTextForm utilsView = CreateTextForm();

  @override
  Widget build(BuildContext context) {
    _desconto.text = '0';
    _quantidade.text = '1';
    _price.text = '0,00';
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Frente de caixa'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonClientes(
                    controller: _cliente,
                  ),
                  inputServices(_price, _servico, _nomeServico),
                  TextFormField(
                    controller: _price,
                    decoration: InputDecoration(labelText: 'Preço'),
                    inputFormatters: <TextInputFormatter>[
                      controller.moneyFormater()
                    ],
                    keyboardType: TextInputType.number,
                  ),
                  utilsView.createTextFormFieldNumber(
                      _quantidade, 'Quantidade', '########', 14),
                  utilsView.createTextFormFieldNumber(
                      _desconto, 'Desconto (%)', '########', 14),
                  ListViewItemPedido(
                    controllerDesconto: _desconto,
                    controllerPrice: _price,
                    controllerQuantidade: _quantidade,
                    controllerServico: _servico,
                    controllerNomeServico: _nomeServico,
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
                          .format(data['value'].toString())
                          .toString();
                    },
                    child: Text(data['name'],
                        style: TextStyle(height: 1, fontSize: 10)),
                  ));
            }).toList());
      },
    );
  }

  
}
