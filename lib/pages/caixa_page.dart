import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/controller/caixa_controller.dart';
import 'package:finances/controller/report_controller.dart';
import 'package:finances/controller/servico_controller.dart';
import 'package:finances/models/item_pedido_model.dart';
import 'package:finances/models/order_model.dart';
import 'package:finances/pages/caixa_itens_page.dart';
import 'package:finances/pages/create_text_form.dart';
import 'package:finances/pages/dropdown_generic.dart';
import 'package:finances/pages/dropdown_clientes.dart';
import 'package:finances/pages/listview_item_pedido.dart';
import 'package:finances/pages/pdf_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Create a Form widget.
class CaixaPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  CaixaController controller = CaixaController();
  ReportController reportController = ReportController();

  TextEditingController _cliente = TextEditingController();
  TextEditingController _typeOrder = TextEditingController();

  List<String> types = ['Serviços', 'Pacotes'];

  final CreateTextForm utilsView = CreateTextForm();

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
          title: Text('Realizar cobrança'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Cliente'),
                  DropdownButtonClientes(
                    controller: _cliente,
                  ),
                  Text('Tipo de cobrança'),
                  DropdownButtonGeneric(
                    controller: _typeOrder,
                    itens: types,
                    option: 'Serviço',
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_forward),
          onPressed: () {
            Order order = Order(
                clienteId: _cliente.text,
                orderType: _typeOrder.text,
                orderItens: <ItemPedido>[]);

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ItensCaixaPage(order: order)),
            );
          },
          heroTag: null,
        ),
      ),
    );
  }

  SizedBox spaceBoxWidth(double value) {
    return SizedBox(width: value);
  }

  SizedBox spaceBoxHeigth(double value) {
    return SizedBox(height: value);
  }
}
