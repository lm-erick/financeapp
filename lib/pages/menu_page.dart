import 'package:finances/controller/login_controller.dart';
import 'package:finances/pages/agenda_page.dart';
import 'package:finances/pages/caixa_page.dart';
import 'package:finances/pages/clientes_page.dart';
import 'package:finances/pages/convenios_page.dart';
import 'package:finances/pages/funcionarios_page.dart';
import 'package:finances/pages/pacotes_sevicos_page.dart';
import 'package:finances/pages/report_page.dart';
import 'package:finances/pages/servicos_page.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Menu de operações'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 80,
                        width: 85,
                        child: BottomAppBar(
                            color: Colors.grey[300],
                            child: Column(
                              children: [
                                IconButton(
                                  iconSize: 30.0,
                                  icon: Icon(Icons.person_add_alt_1_rounded),
                                  tooltip: 'Clientes',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ClientesPage()),
                                    );
                                  },
                                ),
                                Text('Clientes')
                              ],
                            ))),
                    SizedBox(
                        height: 80,
                        width: 85,
                        child: BottomAppBar(
                            color: Colors.grey[300],
                            child: Column(
                              children: [
                                IconButton(
                                  iconSize: 30.0,
                                  icon: Icon(Icons.account_circle_rounded),
                                  tooltip: 'Funcionários',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FuncionariosPage()),
                                    );
                                  },
                                ),
                                Text('Funcionários')
                              ],
                            ))),
                    SizedBox(
                        height: 80,
                        width: 85,
                        child: BottomAppBar(
                            color: Colors.grey[300],
                            child: Column(
                              children: [
                                IconButton(
                                  iconSize: 30.0,
                                  icon: Icon(Icons.add_business_rounded),
                                  tooltip: 'Convênios',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ConveniosPage()),
                                    );
                                  },
                                ),
                                Text('Convênios')
                              ],
                            )))
                  ]),
              spaceBoxHeigth(15),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 80,
                        width: 85,
                        child: BottomAppBar(
                            color: Colors.grey[300],
                            child: Column(
                              children: [
                                IconButton(
                                    iconSize: 30.0,
                                    icon: Icon(Icons.assignment_outlined),
                                    tooltip: 'Serviços',
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ServicosPage()),
                                      );
                                    }),
                                Text('Serviços')
                              ],
                            ))),
                    SizedBox(
                        height: 80,
                        width: 85,
                        child: BottomAppBar(
                            color: Colors.grey[300],
                            child: Column(
                              children: [
                                IconButton(
                                    iconSize: 30.0,
                                    icon: Icon(Icons.assignment_outlined),
                                    tooltip: 'Pacotes',
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PacotesPage()),
                                      );
                                    }),
                                Text('Pacotes')
                              ],
                            ))),
                    SizedBox(
                        height: 80,
                        width: 85,
                        child: BottomAppBar(
                            color: Colors.grey[300],
                            child: Column(
                              children: [
                                IconButton(
                                  iconSize: 30.0,
                                  icon: Icon(Icons.perm_contact_calendar),
                                  tooltip: 'Agenda',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AgendaPage()),
                                    );
                                  },
                                ),
                                Text('Agenda')
                              ],
                            ))),
                  ]),
              spaceBoxHeigth(15),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 80,
                        width: 85,
                        child: BottomAppBar(
                            color: Colors.grey[300],
                            child: Column(
                              children: [
                                IconButton(
                                  iconSize: 30.0,
                                  icon: Icon(Icons.request_page_outlined),
                                  tooltip: 'Relatórios',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ReportePage()),
                                    );
                                  },
                                ),
                                Text('Relatórios')
                              ],
                            ))),
                    SizedBox(
                        height: 80,
                        width: 85,
                        child: BottomAppBar(
                            color: Colors.green,
                            child: Column(
                              children: [
                                IconButton(
                                    iconSize: 30.0,
                                    icon: Icon(
                                      Icons.attach_money,
                                      color: Colors.white,
                                    ),
                                    tooltip: 'Caixa',
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CaixaPage()),
                                      );
                                    }),
                                Text(
                                  'Caixa',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ))),
                  ])
            ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.logout),
          backgroundColor: Colors.red,
          onPressed: () {
            LoginController().signOut();
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
