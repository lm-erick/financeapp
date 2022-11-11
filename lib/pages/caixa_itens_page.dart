import 'package:finances/controller/caixa_controller.dart';
import 'package:finances/controller/report_controller.dart';
import 'package:finances/models/item_controller_model.dart';
import 'package:finances/models/item_pedido_model.dart';
import 'package:finances/models/order_model.dart';
import 'package:finances/pages/create_text_form.dart';
import 'package:finances/pages/input_pacote_servico.dart';
import 'package:finances/pages/input_servico.dart';
import 'package:finances/pages/pdf_screen.dart';
import 'package:flutter/material.dart';

// Create a Form widget.
class ItensCaixaPage extends StatelessWidget {
  ItensCaixaPage({Key? key, required this.order}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  CaixaController controller = CaixaController();
  ReportController reportController = ReportController();

  TextEditingController _servico = TextEditingController();
  TextEditingController _nomeServico = TextEditingController();
  TextEditingController _quantidade = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _desconto = TextEditingController();

  List<ItemPedido> orderItens = <ItemPedido>[];

  Order order;

  final CreateTextForm utilsView = CreateTextForm();

  @override
  Widget build(BuildContext context) {
    _desconto.text = '0';
    _quantidade.text = '1';
    _price.text = '0,00';
    print(order.orderType);
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text('Serviços'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [getInput()],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save_rounded),
          onPressed: () {
            reportController.generatePaymentVoucher().then((value) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PDFScreen(path: value)),
              );
            });
          },
          heroTag: null,
        ),
      ),
    );
  }

  Widget getInput() {
    ItemPedidoControllers controllers = ItemPedidoControllers(
        servico: _servico,
        nomeServico: _nomeServico,
        quantidade: _quantidade,
        price: _price,
        desconto: _desconto);

    if (order.orderType.contains('Serviços')) {
      return Column(
        children: [
          Text('Selecione um serviço'),
          utilsView.spaceBoxHeigth(10),
          InputServico(orderItens).getInput(controllers)
        ],
      );
    }

    return InputPacotes(orderItens: orderItens, controllers: controllers);
  }
}
