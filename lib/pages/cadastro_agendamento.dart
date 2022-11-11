import 'package:finances/controller/cliente_controller.dart';
import 'package:finances/pages/dropdown_clientes.dart';
import 'package:finances/pages/dropdown_funcionarios.dart';
import 'package:finances/pages/input_datetime.dart';
import 'package:finances/pages/dropdown_servicos.dart';
import 'package:flutter/material.dart';

// Create a Form widget.
class CadastroAgendamento extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _datahora = TextEditingController();
  final TextEditingController _servico = TextEditingController();
  final TextEditingController _cliente = TextEditingController();
  final TextEditingController _funcionario = TextEditingController();

  final ClienteController controller = ClienteController();

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
          title: Text('Realizar Agendamento'),
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
                  Text('Funcionário'),
                  DropdownButtonFuncionarios(
                    controller: _funcionario,
                  ),
                  Text('Serviço'),
                  DropdownButtonServicos(
                    controller: _servico,
                  ),
                  Text('Horário para agendamento'),
                  //InputDatetime(),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: () async {},
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
